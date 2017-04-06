package com.amr333.zzkj

class Company {

    String name
    static constraints = {
        name(blank:false, maxSize:50)
    }
}
