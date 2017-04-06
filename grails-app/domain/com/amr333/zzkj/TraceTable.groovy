package com.amr333.zzkj


class TraceTable {
    //订单信息
    Date orderDate
    Integer orderAmount
    String spareNumber
    BigDecimal orderPrice


    //发货信息
    Integer deliveryedAmount
    Integer notDevliveryedAmout

    static hasMany = [deliverys : Delivery]
    static belongsTo = [spare: Spare, company: Company]

    //反馈信息
    Date beginUseTime
    Date endUseTime
    Float outputPerHour
    Float totalOutput
    Integer qualified
    String remark

    static constraints = {
        spare()
        company()
        spareNumber(unique: true)
        orderDate(blank:false)
        orderAmount(blank:false)
        orderPrice(blank:false)
        deliveryedAmount(blank:false)
        notDevliveryedAmout(blank:false)


        beginUseTime(blank:true,nullable: true)
        endUseTime(blank:true,nullable: true)
        outputPerHour(blank:true,nullable: true)
        totalOutput(blank:true,nullable: true)
        qualified(blank:true,nullable: true)
        remark(blank:true,nullable: true)


    }
}
