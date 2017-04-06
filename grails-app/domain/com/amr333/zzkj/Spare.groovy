package com.amr333.zzkj

class Spare {

    String category
    String number
    String zljxh
    String sizes
    String radius
    String percent
    String material
    BigDecimal price
    static constraints = {
        category()
        number(nullable: true)
        zljxh(nullable: true)
        sizes(nullable: true)
        radius(nullable: true)
        percent(nullable: true)
        price(nullable: true)
        material(nullable: true)
    }

}
