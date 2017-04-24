package com.amr333.zzkj

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

        exportService.export("excel", response.outputStream, summaryList.toList(),fields, labels, [:], parameters)


    }
}
