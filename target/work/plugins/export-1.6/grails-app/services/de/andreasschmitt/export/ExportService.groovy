package de.andreasschmitt.export

import de.andreasschmitt.export.exporter.Exporter
import de.andreasschmitt.export.exporter.ExporterNotFoundException
import de.andreasschmitt.export.exporter.ExportingException
import javax.servlet.http.*

class ExportService {

    boolean transactional = false
    
    def exporterFactory
	def grailsApplication

    public void export(String type, OutputStream outputStream, List objects, Map formatters, Map parameters) throws ExportingException {
    	export(type, outputStream, objects, null, null, formatters, parameters)
    }
    
    public void export(String type, OutputStream outputStream, List objects, List fields, Map labels, Map formatters, Map parameters) throws ExportingException {
    	Exporter exporter = exporterFactory.createExporter(type, fields, labels, formatters, parameters)
    	exporter.export(outputStream, objects)
    }

    public void export(String type, OutputStream outputStream, List objects, List fields, Map labels, Map formatters, Map parameters,Object[] otherParamenters) throws ExportingException {
        Exporter exporter = exporterFactory.createExporter(type,null, fields, labels, formatters, parameters, otherParamenters)
//        synchronized Exporter createExporter(String type, Object domain, List fields, Map labels, Map formatters, Map parameters, Object[] otherParameters) throws ExporterNotFoundException {

            exporter.export(outputStream, objects)
    }
   
    public void export(String type, HttpServletResponse response, String filename, String extension, List objects, Map formatters, Map parameters) throws ExportingException {
    	export(type, response, filename, extension, objects, null, null, formatters, parameters)
    }

    public void export(String type, HttpServletResponse response, String filename, String extension, List objects, List fields, Map labels, Map formatters, Map parameters) throws ExportingException {
    	// Setup response
    	response.contentType = grailsApplication.config.grails.mime.types[type]
		response.setHeader("Content-disposition", "attachment; filename=${filename}.${extension}")
    	
    	Exporter exporter = exporterFactory.createExporter(type, fields, labels, formatters, parameters)    	
    	exporter.export(response.outputStream, objects)
    }

    public void export(String type, HttpServletResponse response, String filename, String extension, List objects, List fields, Map labels, Map formatters, Map parameters,Object[] otherParameters) throws ExportingException {
        // Setup response
        response.contentType = grailsApplication.config.grails.mime.types[type]
        response.setHeader("Content-disposition", "attachment; filename=${filename}.${extension}")

        Exporter exporter = exporterFactory.createExporter(type, fields, labels, formatters, parameters, otherParameters)
        exporter.export(response.outputStream, objects)
    }

}
