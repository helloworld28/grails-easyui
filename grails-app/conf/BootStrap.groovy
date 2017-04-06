import grails.converters.JSON
import org.codehaus.groovy.grails.commons.GrailsApplication
import com.amr333.zzkj.EasyuiDomainClassMarshaller
class BootStrap {
    GrailsApplication grailsApplication

    def init = { servletContext ->
        JSON.registerObjectMarshaller(new EasyuiDomainClassMarshaller(true, grailsApplication))
        JSON.registerObjectMarshaller(Date) {
            return it?.format("yyyy-MM-dd HH:mm:ss")?.replace(" 00:00:00", "")
        }
    }
    def destroy = {
    }
}
