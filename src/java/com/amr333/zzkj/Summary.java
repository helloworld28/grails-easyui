package com.amr333.zzkj;

import java.math.BigDecimal;

/**
 * Created by Administrator on 2017-01-20.
 */
public class Summary {

    private String companyName;
    private int amount = 0;
    private BigDecimal totalPrice = new BigDecimal("0");

    public Summary(String companyName, Integer amount, BigDecimal totalPrice) {
        this.companyName = companyName;
        sumTotalPrice(amount, totalPrice);
    }

    public void sumTotalPrice(Integer amount, BigDecimal orderPrice){
        this.amount += amount;
        this.totalPrice = totalPrice.add(orderPrice.multiply(new BigDecimal(String.valueOf(amount))));
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }
}
