package com.amr333.zzkj

import org.apache.catalina.Session
import org.apache.commons.beanutils.BeanUtils
import org.apache.commons.lang.time.DateUtils

import java.text.SimpleDateFormat

/**
 * 总公司汇总生成报表
 */
class ReportController {

    def exportService
    def grailsApplication

    def index() {}
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd")

    def summary() {
        def summaryList
        def companyMap
        if (params.startTime) {

            Date startTime = dateFormat.parse(params.startTime)
            Date endTime = params.endTime ? dateFormat.parse(params.endTime) : new Date()
            endTime = DateUtils.addDays(endTime, 1);

            List < TraceTable > traceTableList = TraceTable.findAllByOrderDateBetween(startTime, endTime)

            Map<String, Summary> map = new HashMap<>()
            traceTableList.each { TraceTable traceTable ->

                Summary summary = map.get(traceTable.getCompany().name)

                if (!summary) {
                    summary = new Summary(traceTable.getCompany().name, traceTable.getOrderAmount(), traceTable.orderPrice)
                } else {
                    summary.sumTotalPrice(traceTable.orderAmount, traceTable.orderPrice)
                }
                map.put(traceTable.company.name, summary)

            }
            summaryList = map.values()
        }

        Long totalAmount = 0;
        BigDecimal totalPrice = new BigDecimal("0")
        summaryList.each { Summary summary ->
            totalAmount += summary.amount
            totalPrice = totalPrice.add(summary.totalPrice)
        }


        session.setAttribute("summaryList", summaryList)
        session.setAttribute("totalAmount", totalAmount)
        session.setAttribute("totalPrice", totalPrice)
        session.setAttribute("startTime", params.startTime)
        session.setAttribute("endTime", params.endTime)
        [summaryList: summaryList, totalAmount: totalAmount, totalPrice: totalPrice]
    }

    def export() {

        def summaryList = session.getAttribute("summaryList")
        String startTime = session.getAttribute("startTime")
        String endTime = session.getAttribute("endTime")

//        if(params?.format && params.format != "html"){
        response.contentType = grailsApplication.config.grails.mime.types['excel']
        def fileName = "summany-" + startTime + "-" + endTime + ".xls"
        response.setHeader("Content-disposition", "attachment;filename=" + fileName)
        List fields = ["companyName", "amount", "totalPrice"]
        Map labels = ["companyName": "公司", "amount": "数量", "totalPrice": "总价"]
        def titles = ["总数量：" + session.totalAmount + ",总价：" + session.totalPrice]
        Map parameters = ["titles": titles, "header.rows": "3", "column.widths": [0.4, 0.3, 0.3]]

        Map sheetMap = new HashMap();

        sheetMap.put("fields", fields);
        sheetMap.put("labels", labels);
        sheetMap.put("parameters",parameters)
        sheetMap.put("datas", summaryList.toList())
        def otherParameters = new Object[1]
       otherParameters[0] =  sheetMap
        buildDetailSheets()
        exportService.export("excelWithSheets", response.outputStream, summaryList.toList(), fields, labels, [:], parameters, otherParameters)
//        }
//
//        [ bookInstanceList: Company.list( params ) ]


    }

    private Object[] buildDetailSheets(){
        List fields = ["spare_number", "companyName", "contractNo","category","zljxh","material","radius","spareNumber","orderDate","orderPrice","deliveryedAmount"]
        Map labels = ["spare_number":"易损件型号", "companyName":"公司名称", "contractNo":"合同号","category":"品类",
                      "zljxh":"制粒机型号","material":"材料","radius":"孔径","spareNumber":"生产编号",
                      "orderDate":"订单日期","orderPrice":"报价","deliveryedAmount":"已发数量"]
        Map parameters = ["titles": "", "header.rows": "3", "column.widths": [0.4, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3, 0.3]]


        List  summaryList = session.summaryList
        String startTimeStr =  session.getAttribute("startTime")
        String endTimeStr = session.setAttribute("endTime")
        Date startTime = dateFormat.parse(startTimeStr)
        Date endTime =endTimeStr ? dateFormat.parse(endTimeStr) : new Date()
        endTime = DateUtils.addDays(endTime, 1);

        def sheets = new Object[summaryList.size()];


        int i = 0;
        summaryList.each {summary ->
            Company company = Company.findByName(summary.companyName);

            List < TraceTable > traceTableList = TraceTable.findAllByCompanyAndOrderDateBetween(company, startTime, endTime)
            List<Detail> detailList = new ArrayList<>()
            traceTableList.each { traceTable ->
                Detail detail = new Detail();

                BeanUtils.copyProperties(detail, traceTable);
                detailList.add(detail)
            }


            String spare_number;
            String companyName;
            String contractNo;
            String category;
            String zljxh;
            String material;
            String radius;
            String spareNumber;
            String orderDate;
            String orderPrice;
            String deliveryedAmount;


            Map sheetMap = new HashMap()
            sheetMap.put("sheetName", summary.companyName)
            sheetMap.put("fields", fields);
            sheetMap.put("labels", labels);
            sheetMap.put("parameters",parameters)
            sheetMap.put("datas", detailList.toList())
            sheets[i++] = sheetMap

        }

        println sheets;
       return sheets;
    }


}
