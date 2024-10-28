package controller;

import java.io.IOException;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.data.TicketDAO;

@WebServlet(urlPatterns = "/ticket/*")
public class TicketController extends HttpServlet {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("ticketflow");
    private TicketDAO dao;

    @Override
    public void init() throws ServletException {
        super.init();
        dao = new TicketDAO(emf);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getRequestURI();
        switch (path.substring(path.lastIndexOf("/") + 1, path.length())) {
            case "list": 
                list(req, resp);
                break;
        
            default:
                System.out.println("Error! Request not found!");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getRequestURI();
        switch (path.substring(path.lastIndexOf("/") + 1, path.length())) {
            case "create":
                create(req, resp);
                break;
            
            default:
                System.out.println("Error! Request not found!");
                break;
        }
    }

    private void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
    }

    private void create(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
    }
    
}
