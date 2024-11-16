package controller;

import java.io.IOException;

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

@WebServlet(urlPatterns = "/note/*")
public class NoteController extends HttpServlet {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("ticketflow");
    private NoteDAO dao;
    private TicketDAO tdao;

    @Override
    public void init() throws ServletException {
        super.init();
        dao = new NoteDAO(emf);
        tdao = new TicketDAO(emf);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // TODO Auto-generated method stub
        super.doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getRequestURI();
        switch (path.substring(path.lastIndexOf("/") + 1, path.length())) {
            case "post":
                create(req, resp);
                break;

            default:
                System.out.println("PostError: Error! Request not found!");
                break;
        }
    }

    private void create(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String editor = req.getParameter("editor");
        Ticket ticket = tdao.getById(req.getParameter("ticketId"));
        User user = (User) session.getAttribute("user");

        Note note = new Note(editor, user, ticket);
        boolean status = dao.insert(note);

        if (status) {
            resp.sendRedirect(req.getContextPath() + "/ticket/details?id=" + ticket.getId());
        } else {
            resp.sendRedirect(req.getContextPath() + "/ticket/details?id=" + ticket.getId() + "&error=1");
        }

    }
    
}
