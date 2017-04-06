package cpm

class AdminFilterFilters {

    def filters = {
        adminOnly(controller:'user|company|spare|report|traceTable|delivery|reportCompany', action:'*') {
            before = {
                if (!session.user){
                    redirect(controller: 'auth', action: 'index')
                    return false
                }
            }

        }
    }
}
