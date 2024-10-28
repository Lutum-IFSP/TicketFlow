package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.data.TicketDAO;
import model.entity.Ticket;
import model.entity.User;
import model.enums.Priority;
import model.enums.Role;

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
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        Role role = user.getRole();

        if ( role == Role.ADMIN || role == Role.TECHNICIAN ) {
            ArrayList<Ticket> listUndefined = dao.getByPriority(Priority.UNDEFINED);
            ArrayList<Ticket> listLow = dao.getByPriority(Priority.LOW);
            ArrayList<Ticket> listMid = dao.getByPriority(Priority.MID);
            ArrayList<Ticket> listHigh = dao.getByPriority(Priority.HIGH);
        } else {
            
        }
    }

    private void create(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
    }
    
}
