package com.amr333.zzkj

import org.apache.commons.beanutils.BeanUtils
import org.apache.commons.lang.time.DateUtils

import java.text.SimpleDateFormat

class ReportCompanyAndSpareController {


    def exportService
    def grailsApplication
    def index() { }
    SimpleDateFormat dateFormat =  new SimpleDateFormat("yyyy-MM-dd")

    def summary(){
        def summaryList
        if(params.startTime){
            Spare spare = Spare.get(params.spare)
            session.spareId = spare?.id
            Company company = Company.get(params.company)
            session.companyName = company?.name
            session.companyId = company?.id
            Date startTime = dateFormat.parse(params.startTime)
            Date endTime = params.endTime ? dateFormat.parse( params.endTime ) : new Date()
            List<TraceTable> traceTableList = TraceTable.findAllBySpareAndCompanyAndOrderDateBetween(spare, company,startTime, endTime)

            Map<String,Map> map = new HashMap<>()
            traceTableList.each {TraceTable traceTable ->
                CompanyAndSpareSummary companyAndSpareSummary = new CompanyAndSpareSummary(traceTable.spare.number, traceTable.orderAmount,traceTable.orderPrice)
                map.put(traceTable.spareNumber, companyAndSpareSummary)

            }
            summaryList = map.values()
        }

        Long totalAmount = 0;
        BigDecimal totalPrice = new BigDecimal("0")
        summaryList.each{ CompanyAndSpareSummary companyAndSpareSummary->
            totalAmount += companyAndSpareSummary.amount
            totalPrice = totalPrice.add(companyAndSpareSummary.totalPrice)
        }


        session.setAttribute("summaryList", summaryList)
        session.setAttribute("totalAmount", totalAmount)
        session.setAttribute("totalPrice", totalPrice)
        session.setAttribute("startTime", params.startTime)
        session.setAttribute("endTime", params.endTime)
        [summaryList: summaryList, totalAmount: totalAmount, totalPrice:totalPrice]
    }

    def export(){

        def  summaryList =  session.getAttribute("summaryList")
        String startTime = session.getAttribute("startTime")
        String endTime = session.getAttribute("endTime")


        response.contentType = grailsApplication.config.grails.mime.types['excel']
        def fileName = "spare-"+startTime+"-"+endTime+".xls"
        response.setHeader("Content-disposition", "attachment;filename="+fileName)
        List fields = ["name", "amount", "price","totalPrice"]
        Map labels = ["name": "易损件生产编号", "amount": "数量","price":"单价", "totalPrice":"总价"]

        String companyName = session.companyName
        def titles = [companyName+"总数量："+session.totalAmount+",总价："+session.totalPrice]
        Map parameters = ["titles":titles,"header.rows":"3","column.widths": [0.5, 0.2, 0.3]]


        def sheets = buildDetailSheets()
        exportService.export("excelWithSheets", response.outputStream, summaryList.toList(), fields, labels, [:], parameters, sheets)


    }

    private Object[] buildDetailSheets(){
        List fields = ["spare_number", "companyName", "contractNo","category","zljxh","material","radius","spareNumber","orderDate","orderPrice","deliveryedAmount","deliveryedTime"]
        Map labels = ["spare_number":"易损件型号", "companyName":"公司名称", "contractNo":"合同号","category":"品类",
                      "zljxh":"制粒机型号","material":"材料","radius":"孔径","spareNumber":"生产编号",
                      "orderDate":"订单日期","orderPrice":"报价","deliveryedAmount":"已发数量","deliveryedTime":"发货时间"]



        def  summaryList = session.summaryList
        def startTimeStr =  session.getAttribute("startTime")
        def endTimeStr = session.getAttribute("endTime")
        Date startTime = dateFormat.parse(startTimeStr)
        Date endTime =endTimeStr ? dateFormat.parse(endTimeStr) : new Date()
        endTime = DateUtils.addDays(endTime, 1);

        def sheets = new Object[1];

        Company company = Company.get(session.getAttribute("companyId"))
        Spare spare = Spare.get(session.getAttribute("spareId"))

        int i = 0;

            List<TraceTable> traceTableList = TraceTable.findAllBySpareAndCompanyAndOrderDateBetween(spare, company,startTime, endTime)
            List<TraceDetailForExport> detailList = new ArrayList<>()
            traceTableList.each { traceTable ->
                TraceDetailForExport detail = new TraceDetailForExport();

                BeanUtils.copyProperties(detail, traceTable)
                BeanUtils.copyProperties(detail, traceTable.spare)
                detail.setCompanyName(traceTable.company.name)
                detail.setSpare_number(traceTable.spare.number)
                detailList.add(detail)
            }


            Map sheetMap = new HashMap()
            sheetMap.put("sheetName", company.name)
            sheetMap.put("fields", fields);
            sheetMap.put("labels", labels);
            sheetMap.put("titles", [String.format("公司：%s ，数量：%s, 总价：%s", company.getName(), session.totalAmount, session.totalPrice)])
            sheetMap.put("header.rows", "3")
            sheetMap.put("column.widths", [0.3, 0.2, 0.2, 0.2, 0.2, 0.2, 0.1, 0.2, 0.1, 0.2, 0.2,0.2])

            sheetMap.put("datas", detailList.toList())
            sheets[i++] = sheetMap



        return sheets;
    }

}
