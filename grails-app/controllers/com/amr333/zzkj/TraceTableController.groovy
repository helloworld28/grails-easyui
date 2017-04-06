package com.amr333.zzkj

import grails.converters.JSON

import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class TraceTableController {

	static allowedMethods = [create: "POST", update: "POST", delete: "POST"]

	SimpleDateFormat timeFormatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
	def index() {
		render (view: "list")
	}

	def list() {
		params.max = params.rows as Integer
		params.page = params.page == null ? 1 : params.page
		params.max = params.max == null ? 20 : params.max
		params.offset = ((params.page as Integer) -1) * params.max

		def c = TraceTable.createCriteria()
		def results = c.list(max: params.max, offset: params.offset) {
			if(params.value){
				if(params.field == "company"){
					eq(params.field, Company.findByName(params.value))
				}else if(params.field == "spare"){
					eq(params.field, Spare.findByNumber(params.value))
				}else{
					eq(params.field, params.value)
				}


			}
			if(params.companyId){
				eq("company", Company.get(params.companyId))
			}
			if(params.spareId){
				eq("spare", Spare.get(params.spareId))
			}
		}

		respond( [rows: results, total: results.getTotalCount()] )
	}

	def show(TraceTable traceTableInstance) {
		respond traceTableInstance
	}

	@Transactional
	def create() {

		params.orderDate = dateFormatter.parse(params.orderDate)
		def traceTableInstance = new TraceTable(params)
		traceTableInstance.orderPrice = traceTableInstance.spare.price
		traceTableInstance.deliveryedAmount=0
		traceTableInstance.notDevliveryedAmout= traceTableInstance.orderAmount

		def errors = save(traceTableInstance)

		if (errors){
			respond errors, [status: NOT_ACCEPTABLE]
			return
		}

		respond traceTableInstance, [status: CREATED]
	}

	@Transactional
	def update(TraceTable traceTableInstance) {

		if (traceTableInstance == null) {
			notFound()
			return
		}

		traceTableInstance.orderDate =  dateFormatter.parse(params.orderDate)
		if(params.beginUseTime != ""){
			traceTableInstance.beginUseTime = timeFormatter.parse(params.beginUseTime)
		}
		if(params.endUseTime != ""){
			traceTableInstance.endUseTime = timeFormatter.parse(params.endUseTime)
		}
		traceTableInstance.clearErrors()
		def errors = save(traceTableInstance)
		if (errors){
			respond errors, [status: NOT_ACCEPTABLE]
			return
		}

		respond traceTableInstance, [status: OK]
	}
		
	@Transactional
	def delete(TraceTable traceTableInstance) {

		if (traceTableInstance == null) {
			notFound()
			return
		}
		
		traceTableInstance.delete flush:true
		render status: OK
	}

	def summary(){
		def summaryList
		Long totalAmount = 0;
		BigDecimal totalPrice = new BigDecimal("0")

			def c = TraceTable.createCriteria()
			def result = c.list {
				if(params.company){
					eq("company", Company.get(params.company))
				}
				if(params.spare){
					eq("spare", Company.get(params.spare))
				}
				if(params.startTime){
					Date startTime = dateFormatter.parse(params.startTime)
					Date endTime = params.endTime ? dateFormatter.parse( params.endTime ) : new Date()
					between("orderDate", startTime, endTime)
				}

			}


			Map<String, TraceTableSummary> map = new HashMap<>()
			result.each {TraceTable traceTable ->
				String key = traceTable.spareId+ "_"+ traceTable.companyId
				TraceTableSummary traceTableSummary = map.get(key)
				if(traceTableSummary){
					traceTableSummary.sum(traceTable.orderAmount, traceTable.orderPrice)
				}else{
					String companyName = traceTable.company.name
					String spareNumber = traceTable.spare.number
					Integer orderAmount = traceTable.orderAmount
					traceTableSummary = new TraceTableSummary(companyName, spareNumber, orderAmount, traceTable.orderPrice)
				}
				map.put(key, traceTableSummary)
			}
			summaryList = map.values()


			summaryList.each{
				totalAmount += it.amount
				totalPrice = totalPrice.add(it.totalPrice)
			}


		[summaryMap: map, totalAmount: totalAmount, totalPrice:totalPrice]


	}



		
	protected def save(TraceTable traceTableInstance) {
		
		if (!traceTableInstance.validate()) {
			return traceTableInstance.errors
		}

		traceTableInstance.save flush:true
		return null
	}
	
	protected void notFound() {
		render status: NOT_FOUND, text: message(code: 'default.not.found.message')
	}

	def feedBackForm(){
		render(view:"feedback")
	}

	def queryTraceTable(){
		TraceTable traceTable = TraceTable.findBySpareNumber(params.spareNumber)
		render traceTable as JSON
	}

	@Transactional
	def saveFeedback(){
		if(params.id){
			TraceTable traceTable = TraceTable.get(params.id)
			traceTable.beginUseTime = timeFormatter.parse(params.beginUseTime)
			traceTable.endUseTime = timeFormatter.parse(params.endUseTime)
			traceTable.outputPerHour = params.outputPerHour as Float
			traceTable.totalOutput = params.totalOutput as Float
			traceTable.remark = params.remark
			traceTable.qualified = params.qualified as Integer
			traceTable.save()
			render "1"
		}else{
			render "0"
		}
	}

	
}
