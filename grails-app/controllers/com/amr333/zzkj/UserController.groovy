package com.amr333.zzkj

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Transactional(readOnly = true)
class UserController {

	static allowedMethods = [create: "POST", update: "POST", delete: "POST"]	

	def index() {
		render (view: "list")
	}

	def home(){
		render(view:"../index")
	}

	def list() {
		params.max = params.rows as Integer
		params.offset = ((params.page as Integer) -1) * params.max

		//TODO: Create filter with "params.field" and "params.value"
		def c = User.createCriteria()
		def results = c.list(max: params.max, offset: params.offset) {
			eq('userType', 'branceCompany')
			if(params.value){
				like(params.field, "%"+params.value+"%")
			}
		}


		respond( [rows: results, total: results.getTotalCount()] )
	}

	def show(User userInstance) {
		respond userInstance
	}

	@Transactional
	def create() {
		def userInstance = new User(params)

		userInstance.userType="branceCompany"
		userInstance.company = Company.get(params.company)

		def errors = save(userInstance)

		if (errors){
			respond errors, [status: NOT_ACCEPTABLE]
			return
		}

		respond userInstance, [status: CREATED]
	}
	@Transactional
	def updatePwd(){
		User user = session.user
		user.password = params.password
		user.save()
		render "1"
	}

	@Transactional
	def update(User userInstance) {

		if (userInstance == null) {
			notFound()
			return
		}

		def errors = save(userInstance)
		if (errors){
			respond errors, [status: NOT_ACCEPTABLE]
			return
		}

		respond userInstance, [status: OK]
	}
		
	@Transactional
	def delete(User userInstance) {

		if (userInstance == null) {
			notFound()
			return
		}
		
		userInstance.delete flush:true
		render status: OK
	}
		
	protected def save(User userInstance) {
		
		if (!userInstance.validate()) {
			return userInstance.errors
		}

		userInstance.save flush:true
		return null
	}
	
	protected void notFound() {
		render status: NOT_FOUND, text: message(code: 'default.not.found.message')
	}
	
}
