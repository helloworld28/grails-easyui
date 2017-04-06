package com.amr333.zzkj

class AuthController {

    def index() {
        render(view: "../login")
    }

    def login(){
        if(session.user){
            redirect(controller: "user", action: "home")

        }
        if(params.userName && params.password && params.userType){
            User user = User.findByUserNameAndPasswordAndUserType(params.userName, params.password, params.userType)
            if(user){
                session.user = user
                session.company = user.company
                redirect(controller: "user", action: "home")
            }else{
                flash.message="用户或密码错误"
                render(view: "../login")
            }
        }else {
            render(view: "../login")
        }
    }

    def logout(){
        session.user = null
        render(view: "../login")
    }
}
