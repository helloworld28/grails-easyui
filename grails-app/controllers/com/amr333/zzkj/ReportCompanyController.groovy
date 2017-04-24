package com.amr333.zzkj

import java.text.SimpleDateFormat

/**
 * 分公司汇总生成报表
 */
class ReportCompanyController {

    def exportService
    def grailsApplication

    def index() {}
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd")

    def summary() {
        def summaryList
        if (params.startTime) {
            Company company = Company.get(params.company)
            session.companyName = company.name
            session.companyId = company.id
            Date startTime = dateFormat.parse(params.startTime)
            Date endTime = params.endTime ? dateFormat.parse(params.endTime) : new Date()
            List<TraceTable> traceTableList = TraceTable.findAllByCompanyAndOrderDateBetween(company, startTime, endTime)

            Map<String, Summary> map = new HashMap<>()
            traceTableList.each { TraceTable traceTable ->

                Summary summary = map.get(traceTable.spare.number)
                if (!summary) {
                    summary = new Summary(traceTable.spare.number, traceTable.getOrderAmount(), traceTable.orderPrice)
                } else {
                    summary.sumTotalPrice(traceTable.orderAmount, traceTable.orderPrice)
                }
                map.put(traceTable.spare.number, summary)

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


        response.contentType = grailsApplication.config.grails.mime.types['excel']
        def fileName = "company-" + startTime + "-" + endTime + ".xls"
        response.setHeader("Content-disposition", "attachment;filename=" + fileName)
        List fields = ["companyName", "amount", "totalPrice"]
        Map labels = ["companyName": "易损件型号", "amount": "数量", "totalPrice": "总价"]
        String companyName = session.companyName
        def titles = [companyName + "总数量：" + session.totalAmount + ",总价：" + session.totalPrice]
        Map parameters = ["titles": titles, "header.rows": "3", "column.widths": [0.5, 0.2, 0.3]]

        exportService.export("excel", response.outputStream, summaryList.toList(), fields, labels, [:], parameters)


    }


}
