package com.amr333.zzkj;

import java.math.BigDecimal;

/**
 * 分公司报表数据封装类
 * Created by Administrator on 2017-01-20.
 */
public class CompanyAndSpareSummary  {

    private String name;
    private int amount = 0;
    private BigDecimal price = new BigDecimal("0");
    private BigDecimal totalPrice = new BigDecimal("0");

    public CompanyAndSpareSummary(String name, Integer amount, BigDecimal totalPrice) {
        this.name = name;
        this.price = totalPrice;
        this.amount = amount;
        this.totalPrice = this.price.multiply(new BigDecimal(amount));
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }
}
