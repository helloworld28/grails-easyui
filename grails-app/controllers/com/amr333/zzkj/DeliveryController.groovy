package com.amr333.zzkj

import grails.converters.JSON

import java.text.SimpleDateFormat

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class DeliveryController {

	static allowedMethods = [create: "POST", update: "POST", delete: "POST"]	

	def index() {
		render (view: "list")
	}

	def list() {
		params.max = params.rows as Integer
		params.offset = ((params.page as Integer) -1) * params.max

		params.sort="deliveryTime"
		params.order="desc"

		respond( [rows: Delivery.list(params), total: Delivery.count()] )
	}

	def listByTraceTable(){
		TraceTable traceTable = TraceTable.get(params.traceTableId as Integer)
		render ([rows: traceTable.deliverys, total: traceTable.deliverys.size()] as JSON)
	}

	def viewListAccept(){
		render (view: "listAccept")
	}




	def listAccept() {
		params.max = params.rows as Integer
		params.offset = ((params.page as Integer) -1) * params.max


		def c = Delivery.createCriteria()
		def results = c.list(max: params.max, offset: params.offset) {
			if(session.user.userType=='branceCompany'){

				def traceTableList = TraceTable.findAllByCompany(session.company)
				'in'("traceTable", traceTableList)
			}
			if(params.value){
				like(params.field, "%"+params.value+"%")
			}
		}

		respond( [rows: results, total: results.getTotalCount()] )
	}
	@Transactional
	def accept(){
		Delivery delivery = Delivery.get(params.id)
		if(delivery){
			delivery.state =1
			delivery.acceptTime = new Date()
			delivery.save(flush: true)
			render "1"
		}else{
			render "0"
		}

	}


	def show(Delivery deliveryInstance) {
		respond deliveryInstance
	}

	@Transactional
	def create() {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		params.deliveryTime = simpleDateFormat.parse(params.deliveryTime)
		def deliveryInstance = new Delivery(params)
		def traceTableId = params.traceTableId as Long
		deliveryInstance.traceTable =  TraceTable.get(traceTableId)
		deliveryInstance.state = 0;

		deliveryInstance.clearErrors()
 		def errors = save(deliveryInstance)

		if (errors){
			respond errors, [status: NOT_ACCEPTABLE]
			return
		}

		respond deliveryInstance, [status: CREATED]
	}

	@Transactional
	def createDevlivery() {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		params.deliveryTime = simpleDateFormat.parse(params.deliveryTime)
		def deliveryInstance = new Delivery(params)
		def traceTableId = params.traceTableId as Long
		TraceTable traceTable = TraceTable.get(traceTableId)
		deliveryInstance.traceTable =  traceTable
		deliveryInstance.state = 0;

		deliveryInstance.clearErrors()
		def errors = save(deliveryInstance)

		if (errors){
			render "0"
		}else{
			//重新计算已发与未发数量
			traceTable.deliveryedAmount += deliveryInstance.deliverAmount
			traceTable.notDevliveryedAmout -= deliveryInstance.deliverAmount
			traceTable.save(flush: true)

			render "1"
		}

	}


	@Transactional
	def update(Delivery deliveryInstance) {

		if (deliveryInstance == null) {
			notFound()
			return
		}

		def errors = save(deliveryInstance)
		if (errors){
			respond errors, [status: NOT_ACCEPTABLE]
			return
		}

		respond deliveryInstance, [status: OK]
	}
		
	@Transactional
	def delete(Delivery deliveryInstance) {

		if (deliveryInstance == null) {
			notFound()
			return
		}

		//更新跟踪表的发货数量信息
		deliveryInstance.traceTable.deliveryedAmount -= deliveryInstance.deliverAmount
		deliveryInstance.traceTable.notDevliveryedAmout += deliveryInstance.deliverAmount
		deliveryInstance.traceTable.save()
		
		deliveryInstance.delete flush:true
		render status: OK
	}
		
	protected def save(Delivery deliveryInstance) {
		
		if (!deliveryInstance.validate()) {
			return deliveryInstance.errors
		}

		deliveryInstance.save flush:true
		return null
	}
	
	protected void notFound() {
		render status: NOT_FOUND, text: message(code: 'default.not.found.message')
	}
	
}
