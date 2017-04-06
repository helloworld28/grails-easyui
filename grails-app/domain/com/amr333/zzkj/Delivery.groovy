package com.amr333.zzkj

class Delivery {

    Date deliveryTime
    String deliveryNumber
    Integer deliverAmount
    Integer state
    Date acceptTime

    static belongsTo = [traceTable: TraceTable]

    static constraints = {
        traceTable()
        deliveryTime(blank:false)
        deliveryNumber(blank: false)
        deliverAmount(blank: false)
        state()
        acceptTime(nullable: true)
    }
}
