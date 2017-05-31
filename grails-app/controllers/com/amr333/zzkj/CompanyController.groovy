package com.amr333.zzkj

import grails.converters.JSON

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CompanyController {

	static allowedMethods = [create: "POST", update: "POST", delete: "POST"]	

	def index() {
		render (view: "list")
	}

	def list() {
		if(params.rows != null && params.page != null){
			params.max = params.rows as Integer
			params.offset = ((params.page as Integer) -1) * params.max
		}

		respond( [rows: Company.list(params), total: Company.count()] )
	}

	def listAll() {

		render  Company.list() as JSON
	}

	def show(Company companyInstance) {
		respond companyInstance
	}

	@Transactional
	def create() {
		def companyInstance = new Company(params)
		def errors = save(companyInstance)

		if (errors){
			respond errors, [status: NOT_ACCEPTABLE]
			return
		}

		respond companyInstance, [status: CREATED]
	}

	@Transactional
	def update(Company companyInstance) {

		if (companyInstance == null) {
			notFound()
			return
		}

		def errors = save(companyInstance)
		if (errors){
			respond errors, [status: NOT_ACCEPTABLE]
			return
		}

		respond companyInstance, [status: OK]
	}
		
	@Transactional
	def delete(Company companyInstance) {

		if (companyInstance == null) {
			notFound()
			return
		}
		
		companyInstance.delete flush:true
		render status: OK
	}
		
	protected def save(Company companyInstance) {
		
		if (!companyInstance.validate()) {
			return companyInstance.errors
		}

		companyInstance.save flush:true
		return null
	}
	
	protected void notFound() {
		render status: NOT_FOUND, text: message(code: 'default.not.found.message')
	}
	
}
