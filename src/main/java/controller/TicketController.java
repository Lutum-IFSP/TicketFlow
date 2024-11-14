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
import model.data.NoteDAO;
import model.data.TicketDAO;
import model.entity.Note;
import model.entity.Ticket;
import model.entity.User;
import model.enums.Priority;
import model.enums.Role;
import model.enums.Stage;

@WebServlet(urlPatterns = "/ticket/*")
public class TicketController extends HttpServlet {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("ticketflow");
    private TicketDAO dao;
    private NoteDAO noteDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        dao = new TicketDAO(emf);
        noteDAO = new NoteDAO(emf);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getRequestURI();
        switch (path.substring(path.lastIndexOf("/") + 1, path.length())) {
            case "list": 
                defineLists(req, resp);
                break;

            case "details":
                detailTicket(req, resp);
                break;
        
            default:
                System.out.println("TicketError: Error! Request not found!");
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

            case "list": 
                defineLists(req, resp);
                break;

            case "change":
                changePriority(req, resp);
                break;

            default:
                System.out.println("TicketError: Error! Request not found!");
                break;
        }
    }

    private void detailTicket(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException  {
        String id = req.getParameter("id");
        Ticket ticket = dao.getById(id);

        if(ticket != null) {
            ArrayList<Note> notes = noteDAO.getAll(ticket);
            User author = ticket.getUser();
            
            req.setAttribute("ticket", ticket);
            req.setAttribute("notes", notes);
            req.setAttribute("author", author);
            req.getRequestDispatcher("/ticket.jsp").forward(req, resp);
        } else {
            req.setAttribute("errorGetTicket", true);
            req.setAttribute("blockAudio", true);
            req.getRequestDispatcher("/tickets.jsp").forward(req, resp);
        }
    }

    private void changePriority(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        Priority priority = Priority.convert(Integer.parseInt(req.getParameter("priority")));
        System.out.println(req.getParameter("priority"));

        Ticket ticket = dao.getById(id);
        System.out.println(ticket);
        ticket.setPriority(priority);
        System.out.println(priority);
        
        boolean status = dao.update(ticket);
        System.out.println(status);
        refreshLists(req, resp);
        
        detailTicket(req, resp);
    }

    private void defineLists(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        Role role = user.getRole();

        if ( role == Role.ADMIN || role == Role.TECHNICIAN ) {
            ArrayList<Ticket> listUndefined = dao.getByPriority(Priority.UNDEFINED);
            ArrayList<Ticket> listLow = dao.getByPriority(Priority.LOW);
            ArrayList<Ticket> listMid = dao.getByPriority(Priority.MID);
            ArrayList<Ticket> listHigh = dao.getByPriority(Priority.HIGH);

            session.setAttribute("listUndefined", listUndefined);
            session.setAttribute("listLow", listLow);
            session.setAttribute("listMid", listMid);
            session.setAttribute("listHigh", listHigh);

            req.getRequestDispatcher("/tickets.jsp").forward(req, resp);
        } else {
            ArrayList<Ticket> listSolved = dao.getByUserAndStage(user, Stage.CLOSED);
            ArrayList<Ticket> listUnresolved = dao.getByUserAndStage(user, Stage.OPEN);
            
            session.setAttribute("listSolved", listSolved);
            session.setAttribute("listUnresolved", listUnresolved);
            
            req.getRequestDispatcher("/tickets.jsp").forward(req, resp);
        }
    }

    private void refreshLists(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        Role role = user.getRole();

        if ( role == Role.ADMIN || role == Role.TECHNICIAN ) {
            ArrayList<Ticket> listUndefined = dao.getByPriority(Priority.UNDEFINED);
            ArrayList<Ticket> listLow = dao.getByPriority(Priority.LOW);
            ArrayList<Ticket> listMid = dao.getByPriority(Priority.MID);
            ArrayList<Ticket> listHigh = dao.getByPriority(Priority.HIGH);

            session.setAttribute("listUndefined", listUndefined);
            session.setAttribute("listLow", listLow);
            session.setAttribute("listMid", listMid);
            session.setAttribute("listHigh", listHigh);

            req.setAttribute("blockAudio", true);

        } else {
            ArrayList<Ticket> listSolved = dao.getByUserAndStage(user, Stage.CLOSED);
            ArrayList<Ticket> listUnresolved = dao.getByUserAndStage(user, Stage.OPEN);
            
            session.setAttribute("listSolved", listSolved);
            session.setAttribute("listUnresolved", listUnresolved);
            
            req.setAttribute("blockAudio", true);
        }
    }
    
    private void create(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String title = req.getParameter("titulo");
        String tags = "";
        String description = "teste";
        Stage stage = Stage.OPEN;
        Priority priority = Priority.UNDEFINED;
        String editor = req.getParameter("editor");
        User user = (User) req.getSession().getAttribute("user");

        Ticket ticket = new Ticket(title, tags, description, stage, priority, user);
        Note initialNote = new Note(editor, user, ticket);
        boolean status = dao.insert(ticket) && noteDAO.insert(initialNote);

        refreshLists(req, resp);

        req.setAttribute("blockAudio", true);
        req.setAttribute("status", status);
        req.getRequestDispatcher("/tickets.jsp").forward(req, resp);

    }
    
}
