package com.amr333.zzkj

import com.google.gson.Gson
import grails.converters.JSON
import grails.transaction.Transactional
import org.apache.commons.lang.StringUtils

import static org.springframework.http.HttpStatus.*

@Transactional(readOnly = true)
class SpareController {

    static allowedMethods = [create: "POST", update: "POST", delete: "POST"]

    def index() {
        render(view: "list")
    }

    def list() {
        params.max = params.rows as Integer
        params.page = params.page == null ? 1 : params.page
        params.max = params.max == null ? 20 : params.max
        params.offset = ((params.page as Integer) - 1) * params.max

        //TODO: Create filter with "params.field" and "params.value"
        def c = Spare.createCriteria()
        def results = c.list(max: params.max, offset: params.offset) {
            if (params.value) {
                like(params.field, "%" + params.value + "%")
            }
        }

        respond([rows: results, total: results.getTotalCount()])
    }

    def listByFilter() {
        params.max = params.rows as Integer
        params.page = params.page == null ? 1 : params.page
        params.max = params.max == null ? 20 : params.max
        params.offset = ((params.page as Integer) - 1) * params.max

        //TODO: Create filter with "params.field" and "params.value"


        def c = Spare.createCriteria()
        def results = c.list(max: params.max, offset: params.offset) {
            if (params.filterRules) {
                List<Map> list = new Gson().fromJson(params.filterRules, List.class);
                for (Map map : list) {
                    String key = map.get("field");
                    String value = map.get("value");
                    if (StringUtils.isNotBlank(value)) {
                        like(key, "%" + value + "%")
                    }
                }
            }
        }

        respond([rows: results, total: results.getTotalCount()])
    }

    def listZljxh(){
       def spares =  Spare.executeQuery("select distinct  a.zljxh as value from Spare a")

        List<Map> list = new ArrayList<>()
        spares.each {
            Map map = Collections.singletonMap("code", it)
            list.add(map)
        }
        render list as JSON
    }


    def show(Spare spareInstance) {
        respond spareInstance
    }

    @Transactional
    def create() {
        def spareInstance = new Spare(params)
        def errors = save(spareInstance)

        if (errors) {
            respond errors, [status: NOT_ACCEPTABLE]
            return
        }

        respond spareInstance, [status: CREATED]
    }

    @Transactional
    def update(Spare spareInstance) {

        if (spareInstance == null) {
            notFound()
            return
        }

        def errors = save(spareInstance)
        if (errors) {
            respond errors, [status: NOT_ACCEPTABLE]
            return
        }

        respond spareInstance, [status: OK]
    }

    @Transactional
    def delete(Spare spareInstance) {

        if (spareInstance == null) {
            notFound()
            return
        }

        spareInstance.delete flush: true
        render status: OK
    }

    protected def save(Spare spareInstance) {

        if (!spareInstance.validate()) {
            return spareInstance.errors
        }

        spareInstance.save flush: true
        return null
    }

    protected void notFound() {
        render status: NOT_FOUND, text: message(code: 'default.not.found.message')
    }

    @Transactional
    def batchInput() {

        def filePath = uploadFile()
        println "上传文件：" + filePath
        SpareImporter spareImporter = new SpareImporter(filePath);
        spareImporter.setGrailsApplication(grailsApplication)
        List spareList = spareImporter.getSpareList()


        spareList.each { Map params ->
            params.number = params.number?.toString().replace(".0", "")
            if (params.number != null) {

                Spare spare = Spare.findByNumber(params.number)
                if (spare) {
                    spare.price = params.price
                    spare.sizes = params.sizes
                    spare.material = params.material
                    spare.category = params.category
                    spare.radius = params.radius
                    spare.percent = params.percent
                    spare.zljxh = params.zljxh
                    spare.save()
                } else {
                    spare = new Spare(params)
                    if (spare.save()) {
                        println "import spare success number" + spare.number
                    } else {
                        println "import spare error number" + spare.number
                    }
                }
            }

        }

        redirect(action: "index")

    }


    def uploadFile() {
        def filePath
        def uploadFile = request.getFile("myFile")
        if (!uploadFile.empty) {

            String basePath = grailsApplication.config.upload.excel.path;
            new File(basePath).mkdirs()

            filePath = basePath + "/" + System.currentTimeMillis() + ".xlsx"
            uploadFile.transferTo(new File(filePath))
        }
        return filePath
    }

    def spare() {

    }


}
