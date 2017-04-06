package com.amr333.zzkj;

import java.math.BigDecimal;

/**
 * Created by Administrator on 2017-01-21.
 */
public class TraceTableSummary {

    private String companyName;
    private String spareNumber;
    private Integer amount;
    private BigDecimal totalPrice = new BigDecimal("0");

    public TraceTableSummary(String companyName, String spareNumber, Integer amount, BigDecimal price) {
        this.companyName = companyName;
        this.spareNumber = spareNumber;
        this.amount = amount;
        this.totalPrice = price.multiply(new BigDecimal(amount));
    }

    public void sum(Integer amount, BigDecimal price){
        this.amount += amount;
        this.totalPrice = totalPrice.add(price);
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getSpareNumber() {
        return spareNumber;
    }

    public void setSpareNumber(String spareNumber) {
        this.spareNumber = spareNumber;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }
}
