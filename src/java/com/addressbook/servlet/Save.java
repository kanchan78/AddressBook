package com.addressbook.servlet;

import com.addressbook.dao.ContactDao;
import com.addressbook.entities.Contact;
import com.addressbook.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@MultipartConfig
public class Save extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();
        try {
            Thread.sleep(1000);

            int conid = Integer.parseInt(request.getParameter("conid"));

            String fname = request.getParameter("fname");

            String lname = request.getParameter("lname");

            String cityn = request.getParameter("cityn");

            String date = request.getParameter("bdate");
            java.util.Date dt1 = new SimpleDateFormat("yyyy-MM-dd").parse(date);
            java.sql.Date sqlDate = new java.sql.Date(dt1.getTime());

            String contc = request.getParameter("contc");

            String faddr = request.getParameter("faddr");

            boolean rview = Boolean.parseBoolean(request.getParameter("rview"));
int zpcod = Integer.parseInt(request.getParameter("zpcod"));
            Contact contact1 = new Contact(conid, fname, lname, cityn, sqlDate, contc,zpcod, faddr, rview);

            ContactDao dao = new ContactDao(ConnectionProvider.getConnection());

            if (dao.updateContact(contact1) > 0) {
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
