package com.amr333.zzkj

import grails.util.Holders

class EasyuiConfig {

	static ConfigObject getConfig() {
		Holders.grailsApplication.config.grails.plugin.easyui
	}

	static String getLocale() {
		getConfig().locale ?: "en"
	}

	static String getTheme() {
		getConfig().theme ?: "default"
	}

	static String getJqueryVersion() {
		getConfig().jquery.version ? "-${getConfig().jquery.version}": ""
	}
	
	static Boolean getRegisterMarshaller() {			
		getConfig().register.marshaller ? getConfig().register.marshaller as Boolean : true
	}
}
