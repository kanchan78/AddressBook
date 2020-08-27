package com.addressbook.dao;

import com.addressbook.entities.Contact;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ContactDao {

    private Connection con;

    public ContactDao(Connection con) {
        this.con = con;
    }

    public boolean saveContact(List<Contact> contacts) {
        try {
            con.setAutoCommit(false);
            String query = "insert into contact (fname,lname,cityn,bdate,contc,faddr,zpcod) values (?,?,?,?,?,?,?)";
            PreparedStatement pst = this.con.prepareStatement(query);
            con.setAutoCommit(false);
            for (Contact contact1 : contacts) {
                pst.setString(1, contact1.getFirst_name());
                pst.setString(2, contact1.getLast_name());
                pst.setString(3, contact1.getCity());
                pst.setDate(4, (Date) contact1.getBirthdate());
                pst.setString(5, contact1.getContact());
                pst.setString(6, contact1.getFull_address());
                pst.setInt(7,contact1.getZip_code());
                pst.addBatch();
            }
            pst.executeBatch();
            con.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    

    public List<Contact> listAllContacts() {
        List<Contact> contacts = new ArrayList<>();
        try {
            String query = "select * from contact";
            Statement statement = this.con.createStatement();
            ResultSet resultSet = statement.executeQuery(query);
            while (resultSet.next()) {
                Contact contact1 = new Contact();
                contact1.setContact_id(resultSet.getInt("conid"));
                contact1.setFirst_name(resultSet.getString("fname"));
                contact1.setLast_name(resultSet.getString("lname"));
                contact1.setCity(resultSet.getString("cityn"));
                contact1.setBirthdate(resultSet.getDate("bdate"));
                contact1.setContact(resultSet.getString("contc"));
                contact1.setFull_address(resultSet.getString("faddr"));
                 contact1.setZip_code(resultSet.getInt("zpcod"));
                contact1.setReview(resultSet.getBoolean("rview"));
                contacts.add(contact1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return contacts;
    }

    public List<Contact> getContacts(String search) {
        List<Contact> contacts = new ArrayList<>();
        try {
            Statement stmt = con.createStatement();
            String query = "select * from contact where fname like '%" + search + "%' or lname like '%" + search + "%' or cityn like '%" + search + "%' or bdate like '%" + search + "%' or contc like '%" + search + "%' or faddr like '%" + search + "%' or zpcod like '%" + search + "%'   ";
            ResultSet resultSet = stmt.executeQuery(query);
            while (resultSet.next()) {
                Contact contact1 = new Contact();
                contact1.setContact_id(resultSet.getInt("conid"));
                contact1.setFirst_name(resultSet.getString("fname"));
                contact1.setLast_name(resultSet.getString("lname"));
                contact1.setCity(resultSet.getString("cityn"));
                contact1.setBirthdate(resultSet.getDate("bdate"));
                contact1.setContact(resultSet.getString("contc"));
                contact1.setFull_address(resultSet.getString("faddr"));
                contact1.setReview(resultSet.getBoolean("rview"));
                contact1.setZip_code(resultSet.getInt("zpcod"));
                contacts.add(contact1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return contacts;
    }

    public boolean deleteContact(int delete_id) {
        try {
            Statement stmt = con.createStatement();
            String query = "delete from contact where conid ='" + delete_id + "'";
            stmt.executeUpdate(query);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Contact getContact(int contact_id) {
        Contact contact1 = null;
        try {
            String query = "select * from contact where conid = '" + contact_id + "'";
            PreparedStatement pstmt = con.prepareStatement(query);

            ResultSet resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                contact1 = new Contact();
                contact1.setContact_id(resultSet.getInt("conid"));
                contact1.setFirst_name(resultSet.getString("fname"));
                contact1.setLast_name(resultSet.getString("lname"));
                contact1.setCity(resultSet.getString("cityn"));
                contact1.setBirthdate(resultSet.getDate("bdate"));
                contact1.setContact(resultSet.getString("contc"));
                contact1.setFull_address(resultSet.getString("faddr"));
                contact1.setReview(resultSet.getBoolean("rview"));
                 contact1.setZip_code(resultSet.getInt("zpcod"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return contact1;
    }

    public int updateContact(Contact contact1) {
        int status = 0;
        try {
            String query = "update contact set fname=?,lname=?,cityn=?,bdate=?,contc=?,faddr=?, rview=?, zpcod=? where conid= ?";
            PreparedStatement pstmt = con.prepareStatement(query);

            pstmt.setString(1, contact1.getFirst_name());
            pstmt.setString(2, contact1.getLast_name());
            pstmt.setString(3, contact1.getCity());
            pstmt.setDate(4, (Date) contact1.getBirthdate());
            pstmt.setString(5, contact1.getContact());
            pstmt.setString(6, contact1.getFull_address());
            pstmt.setBoolean(7, contact1.getReview());
            pstmt.setInt(9, contact1.getContact_id());
            pstmt.setInt(8,contact1.getZip_code());
            status = pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

}
