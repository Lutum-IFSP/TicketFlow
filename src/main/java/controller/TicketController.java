package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.Instant;
import java.util.ArrayList;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.json.JSONArray;
import org.json.JSONObject;

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

            case "search":
                searchTicket(req, resp);
                break;

            case "close":
                closeTicket(req, resp);
                break;
        
            default:
                System.out.println("GTicketError: Error! Request not found!");
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
                System.out.println("PTicketError: Error! Request not found!");
                break;
        }
    }

    private void searchTicket(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        String searchTerm = req.getParameter("q");

        searchTerm = searchTerm.replace("\"", "");

        ArrayList<Ticket> tickets = dao.searchByTitle(searchTerm);

        JSONArray array = new JSONArray();
        for (Ticket ticket : tickets) {
            if (user.getRole() != Role.USER || ticket.getUser().equals(user)) {
                JSONObject object = new JSONObject();
                object.put("id", ticket.getId());
                object.put("title", ticket.getTitle());
                object.put("priority", ticket.getPriority().toString());
                array.put(object);
            } else {
                continue;
            }
        }

        PrintWriter out = resp.getWriter();
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        out.println(array.toString());
        out.flush();
    }

    private void closeTicket(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        Ticket ticket = dao.getById(id);

        ticket.setStage(Stage.CLOSED);
        ticket.setPriority(Priority.UNDEFINED);
        ticket.setClosed(Instant.now());

        boolean status = dao.update(ticket);
        req.setAttribute("deleteStatus", status);
        req.setAttribute("blockAudio", true);

        req.getRequestDispatcher("/ticket/list").forward(req, resp);
    }

    private void detailTicket(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        Ticket ticket = dao.getById(id);
        HttpSession session = req.getSession();

        if(ticket != null) {
            User author = ticket.getUser();
            User user = (User) session.getAttribute("user");

            if (!author.equals(user) && user.getRole() == Role.USER) {
                req.setAttribute("errorGetTicket", true);
                req.setAttribute("blockAudio", true);
                req.getRequestDispatcher("/ticket.jsp").forward(req, resp);
            }

            ArrayList<Note> notes = noteDAO.getAll(ticket);
            
            req.setAttribute("ticket", ticket);
            req.setAttribute("notes", notes);
            req.setAttribute("author", author);
            req.getRequestDispatcher("/ticket.jsp").forward(req, resp);
        } else {
            req.setAttribute("errorGetTicket", true);
            req.setAttribute("blockAudio", true);
            req.getRequestDispatcher("/ticket.jsp").forward(req, resp);
        }
    }

    @SuppressWarnings("unused")
    private void changePriority(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        Priority priority = Priority.convert(Integer.parseInt(req.getParameter("priority")));

        Ticket ticket = dao.getById(id);
        ticket.setPriority(priority);

        boolean status = dao.update(ticket);
        refreshLists(req, resp);
        
        detailTicket(req, resp);
    }

    private void defineLists(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        Role role = user.getRole();

        if( req.getParameter("blockAudio") != null ) {
            req.setAttribute("blockAudio", true);
        }

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
        String description = req.getParameter("editor");
        Stage stage = Stage.OPEN;
        Priority priority = Priority.UNDEFINED;
        User user = (User) req.getSession().getAttribute("user");

        Ticket ticket = new Ticket(title, tags, description, stage, priority, user);
        boolean status = dao.insert(ticket);

        refreshLists(req, resp);

        req.setAttribute("blockAudio", true);
        req.setAttribute("status", status);
        req.getRequestDispatcher("/tickets.jsp").forward(req, resp);

    }
    
}
