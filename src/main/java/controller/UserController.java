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
import model.data.UserDAO;
import model.entity.User;
import model.enums.Role;

@WebServlet("/UserController")
public class UserController extends HttpServlet {
    UserDAO dao;
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("ticketflow");

    @Override
    public void init() throws ServletException {
        super.init();
        dao = new UserDAO(null);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        switch (req.getParameter("oprt")) {
            case "sair":
                logout(req, resp);
                break;

            case "deletar": 
                delete(req, resp);
                break;

            case "listar": 
                list(req, resp);
                break;

            case "buscar":
                find(req, resp);
                break;
        
            default:
                System.out.println("Error! Operation not found!");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        switch (req.getParameter("oprt")) {
            case "cadastrar":
                registerUser(req, resp);
                break;
            
            case "entrar":
                login(req, resp);
                break;
            
            default:
                System.out.println("Error! Operation not found!");
                break;
        }
    }
    
    private void registerUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("senha");
        Role role = Role.valueOf(req.getParameter("role"));
        
        User user = new User("", username, email, password, role, null);
        boolean status = dao.insert(user);

        req.setAttribute("status", status);
        req.getRequestDispatcher("/tickets.html").forward(req, resp);
    }
    
    private void login(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("senha");
        
        User user = dao.findByUsername(username);
        
        if(user != null && user.getPassword().equals(password)) {
            HttpSession session = req.getSession();
			session.setAttribute("user", user);
			
			req.getRequestDispatcher("/tickets.html").forward(req, resp);
		}
		else {
            req.setAttribute("error", true);
			req.getRequestDispatcher("/index.html").forward(req, resp);
		}
    }
    
    private void logout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
		session.invalidate();
		req.getRequestDispatcher("/index.jsp").forward(req, resp);
    }
    
    private void find(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");

        User user = dao.findByUsername(username);
        
        req.setAttribute("user", user);
        req.getRequestDispatcher("/tickets.html").forward(req, resp);
    }

    private void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        ArrayList<User> listUsers = dao.getAllUsers();
        
        req.setAttribute("listUsers", listUsers);
        req.getRequestDispatcher("/tickets.html").forward(req, resp);
    }
        
    private void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");

        User user = dao.findById(id);

        boolean status = dao.delete(user);
        req.setAttribute("status", status);
        req.getRequestDispatcher("/index.html").forward(req, resp);
    }
}
