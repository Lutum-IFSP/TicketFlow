package controller;

import java.io.IOException;
import java.io.PrintWriter;
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
import model.data.TicketDAO;
import model.data.UserDAO;
import model.entity.Ticket;
import model.entity.User;
import model.enums.Stage;


@WebServlet(urlPatterns = "/analytic/*")
public class AnalyticController extends HttpServlet {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("ticketflow");
    private UserDAO userDao;
    private TicketDAO ticketDao;

    @Override
    public void init() throws ServletException {
        super.init();
        userDao = new UserDAO(emf);
        ticketDao = new TicketDAO(emf);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        getData(req, resp);
    }
    
    public void getData(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ArrayList<User> users = new ArrayList<User>();
        ArrayList<Ticket> open = new ArrayList<Ticket>();
        ArrayList<Ticket> closed = new ArrayList<Ticket>();
        ArrayList<Ticket> tickets = new ArrayList<Ticket>();

        users = userDao.getAll();
        System.out.println(users.size());
        open = ticketDao.getByStage(Stage.OPEN);
        closed = ticketDao.getByStage(Stage.CLOSED);
        tickets.addAll(open);
        tickets.addAll(closed);

        JSONArray arrayUsers = new JSONArray();
        for (User user : users) {
            JSONObject object = new JSONObject();
            object.put("id", user.getId());
            object.put("username", user.getUsername());
            object.put("role", String.valueOf(user.getRole()));
            arrayUsers.put(object);
        }
        System.out.println(arrayUsers);
        
        JSONArray arrayOpen = new JSONArray();
        for (Ticket ticket : open) {
            JSONObject object = new JSONObject();
            object.put("id", ticket.getId());
            object.put("title", ticket.getTitle());
            object.put("stage", ticket.getStage());
            object.put("open-date", ticket.getCreated());
            arrayOpen.put(object);
        }
        
        JSONArray arrayClosed = new JSONArray();
        for (Ticket ticket : closed) {
            JSONObject object = new JSONObject();
            object.put("id", ticket.getId());
            object.put("title", ticket.getTitle());
            object.put("stage", ticket.getStage());
            object.put("close-date", ticket.getClosed());
            arrayClosed.put(object);
        }
        
        JSONArray arrayTickets = new JSONArray();
        for (Ticket ticket : tickets) {
            JSONObject object = new JSONObject();
            object.put("id", ticket.getId());
            object.put("title", ticket.getTitle());
            object.put("stage", ticket.getStage());
            arrayTickets.put(object);
        }

        JSONObject arrays = new JSONObject();
        arrays.put("users", arrayUsers);
        arrays.put("open", arrayOpen);
        arrays.put("closed", arrayClosed);
        arrays.put("tickets", arrayTickets);

        PrintWriter out = resp.getWriter();
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        out.println(arrays.toString());
        out.flush();
    }
}
