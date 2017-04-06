package com.amr333.zzkj

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class OrderController {

	static allowedMethods = [create: "POST", update: "POST", delete: "POST"]	

	def index() {
		render (view: "list")
	}

	def list() {
		params.max = params.rows as Integer
		params.offset = ((params.page as Integer) -1) * params.max

		//TODO: Create filter with "params.field" and "params.value"

		respond( [rows: Order.list(params), count: Order.count()] )
	}

	def show(Order orderInstance) {
		respond orderInstance
	}

	@Transactional
	def create() {
		def orderInstance = new Order(params)
		def errors = save(orderInstance)

		if (errors){
			respond errors, [status: NOT_ACCEPTABLE]
			return
		}

		respond orderInstance, [status: CREATED]
	}

	@Transactional
	def update(Order orderInstance) {

		if (orderInstance == null) {
			notFound()
			return
		}

		def errors = save(orderInstance)
		if (errors){
			respond errors, [status: NOT_ACCEPTABLE]
			return
		}

		respond orderInstance, [status: OK]
	}
		
	@Transactional
	def delete(Order orderInstance) {

		if (orderInstance == null) {
			notFound()
			return
		}
		
		orderInstance.delete flush:true
		render status: OK
	}
		
	protected def save(Order orderInstance) {
		
		if (!orderInstance.validate()) {
			return orderInstance.errors
		}

		orderInstance.save flush:true
		return null
	}
	
	protected void notFound() {
		render status: NOT_FOUND, text: message(code: 'default.not.found.message')
	}
	
}
