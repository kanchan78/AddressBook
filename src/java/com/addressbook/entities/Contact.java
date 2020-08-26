package com.addressbook.entities;

import java.util.Date;

public class Contact {

    private int contact_id;
    private String first_name;
    private String last_name;
    private String city;
    private Date birthdate;
    private String contact;
    private String full_address;
    private boolean review;

    public Contact(int contact_id, String first_name, String last_name, String city, Date birthdate, String contact, String full_address, boolean review) {
        this.contact_id = contact_id;
        this.first_name = first_name;
        this.last_name = last_name;
        this.city = city;
        this.birthdate = birthdate;
        this.contact = contact;
        this.full_address = full_address;
        this.review = review;
    }

    public Contact() {
    }

    public int getContact_id() {
        return contact_id;
    }

    public void setContact_id(int contact_id) {
        this.contact_id = contact_id;
    }

    public String getFirst_name() {
        return first_name;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public Date getBirthdate() {
        return birthdate;
    }

    public void setBirthdate(Date birthdate) {
        this.birthdate = birthdate;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getFull_address() {
        return full_address;
    }

    public void setFull_address(String full_address) {
        this.full_address = full_address;
    }

    public boolean getReview() {
        return review;
    }

    public void setReview(boolean review) {
        this.review = review;
    }

}
