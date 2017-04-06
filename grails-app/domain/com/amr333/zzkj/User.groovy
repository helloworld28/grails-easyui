package com.amr333.zzkj

class User {

    String userName
    String password
    String userType
    static belongsTo = [company:Company]

    static constraints = {
        userName(blank:false, maxSize:50, unique: true)
        password(blank: false, maxSize: 50,password:true)
        company(blank:false,nullable: true)

        userType(inList:["admin","zzkj","company","branceCompany"])
        
    }
}
