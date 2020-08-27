package com.addressbook.servlet;

import com.addressbook.dao.ContactDao;
import com.addressbook.entities.Contact;
import com.addressbook.helper.ConnectionProvider;
import com.opencsv.CSVReader;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig
public class Upload extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();

        try {
            Thread.sleep(1000);
            Part part = request.getPart("csvfile");
            String fileName = part.getSubmittedFileName();
            InputStream fileContent = part.getInputStream();
            ///Using CSV Reader
            List<Contact> contacts = new ArrayList<>();
            CSVReader reader = null;
            reader = new CSVReader(new InputStreamReader(fileContent));
            String[] nextLine;
            while ((nextLine = reader.readNext()) != null) {
                Contact contact = new Contact();
                contact.setFirst_name(nextLine[0]);
                contact.setLast_name(nextLine[1]);
                contact.setCity(nextLine[2]);
                String date = nextLine[3];
                java.util.Date dt1 = new SimpleDateFormat("MM/dd/yyyy").parse(date);
                java.sql.Date sqlDate = new java.sql.Date(dt1.getTime());
                contact.setBirthdate(sqlDate);
                contact.setContact(nextLine[4]);
                contact.setFull_address(nextLine[5]);
                contact.setZip_code(Integer.parseInt(nextLine[6]));
                contacts.add(contact);
            }

            ////
//            List<Contact> contacts = new ArrayList<>();
//            String line = "";
//            String splitBy = ",";
//
//            InputStream fileContent = part.getInputStream();
//            BufferedReader br = new BufferedReader(new InputStreamReader(fileContent));
//
//            while ((line = br.readLine()) != null) {
//                String[] record = line.split(splitBy);
//                Contact contact = new Contact();
//                contact.setFirst_name(record[0]);
//                contact.setLast_name(record[1]);
//                contact.setCity(record[2]);
//                String date = record[3];
//                java.util.Date dt1 = new SimpleDateFormat("MM/dd/yyyy").parse(date);
//                java.sql.Date sqlDate = new java.sql.Date(dt1.getTime());
//                contact.setBirthdate(sqlDate);
//                contact.setContact(record[4]);
//                contact.setFull_address(record[5]);
//                contact.setZip_code(Integer.parseInt(record[6]));
//                contacts.add(contact);
//            }
            ContactDao dao = new ContactDao(ConnectionProvider.getConnection());

            if (dao.saveContact(contacts) == true) {
                out.println("done");
            } else {
                out.println("error");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
