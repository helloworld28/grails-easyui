package cpm

import com.amr333.zzkj.Company
import com.amr333.zzkj.CompanyController

import static org.springframework.http.HttpStatus.*

import grails.test.mixin.*
import spock.lang.*

@TestFor(CompanyController)
@Mock(Company)
class CompanyControllerSpec extends Specification {

	def populateValidParams(params) {
		assert params != null
		// TODO: Populate valid properties like...
		//params['name'] = 'someValidName'
	}

	void "Test the index action render correct view"() {

		when:"The index action is executed"
			controller.index()

		then:"Rendered list index"
			view == '/company/list'
	}

	void "Test the create action correctly persists an instance"() {

		when:"The create action is executed with an invalid instance"
			controller.create()

		then:"The response status is NOT_ACCEPTABLE"
			response.status == NOT_ACCEPTABLE.value

		when:"The save action is executed with a valid instance"
			response.reset()
			populateValidParams(params)
			controller.create()

		then:"The response status is CREATED"
			response.status == CREATED.value
	}

	void "Test the update action performs an update on a valid domain instance"() {
		when:"Update is called for a domain instance that doesn't exist"
			controller.update(null)

		then:"The response status is NOT_FOUND"
			response.status == NOT_FOUND.value

		when:"An invalid domain instance is passed to the update action"
			response.reset()
			def company = new Company()
			controller.update(company)

		then:"The response status is NOT_ACCEPTABLE"
			response.status == NOT_ACCEPTABLE.value

		when:"A valid domain instance is passed to the update action"
			response.reset()
			populateValidParams(params)
			company = new Company(params).save(flush: true)
			controller.update(company)

		then:"The response status is OK and the updated instance is returned"
			response.status == OK.value
		  
	}

	void "Test that the delete action deletes an instance if it exists"() {
		when:"The delete action is called for a null instance"
			controller.delete(null)

		then:"A NOT_FOUND is returned"
			response.status == NOT_FOUND.value

		when:"A domain instance is created"
			response.reset()
			populateValidParams(params)
			def company = new Company(params).save(flush: true)

		then:"It exists"
			Company.count() == 1

		when:"The domain instance is passed to the delete action"
			controller.delete(company)

		then:"The instance is deleted"
			Company.count() == 0
			response.status == OK.value
	}
	
}