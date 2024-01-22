/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package prj301demo.servlet;

import prj301demo.utils.DBUtils;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author DUNGHUYNH
 */
public class StudentListServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet StudentListServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Student List </h1>");
            
            String keyword = request.getParameter("keyword");
            String sortCol = request.getParameter("sortCol");
            if (keyword == null) keyword ="";
            out.println("<form action='' method = GET>\n"
                    + " <input name=keyword type=text value = " + keyword + ">\n"
                    + " <input type=submit value=Search>\n"
                    + " </form>");

            out.println("<table><tr><td>id</td>" + ""
                    + "<td><a href=\"?sortCol=firstname&keyword="+keyword+"\">firstname</a></td>"
                    + "<td> <a href=\"?sortCol=lastname&keyword="+keyword+"\">lastname</a></td>"
                    + "<td>age</td></tr>");
            try {
                Connection con = DBUtils.getConnection();
                String sql = "SELECT id, firstname, lastname, age from student ";
                if (keyword != null && !keyword.isEmpty()) {
                    sql += " WHERE firstname like ? or lastname like ? ";
                }
                if (sortCol != null && !sortCol.isEmpty()) {
                    sql += " ORDER BY " + sortCol + " ";
                }
                PreparedStatement stmt = con.prepareStatement(sql);
                
                if (keyword != null && !keyword.isEmpty()) {
                    stmt.setString(1, "%" + keyword + "%");
                    stmt.setString(2, "%" + keyword + "%");
                }
                ResultSet rs = stmt.executeQuery();
                if (rs != null) {
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String firstname = rs.getString("firstname");
                        String lastname = rs.getString("lastname");
                        int age = rs.getInt("age");
                        out.println("<tr><td>" + id + "</td><td>" + firstname + "</td><td>" + lastname + "</td><td>" + age + "</td></tr>");
                    }
                }
                con.close();
            } catch (SQLException e) {
                System.out.println("Wrong syntax SQL");
                e.printStackTrace();
            }

            out.println("</table>");
            out.println("</body>");
            out.println("</html>");
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
