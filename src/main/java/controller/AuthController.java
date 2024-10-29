package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import com.cloudinary.Cloudinary;

import io.github.cdimascio.dotenv.Dotenv;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.auth.Encryptor;
import model.data.UserDAO;
import model.entity.User;
import model.enums.Role;
import model.services.ImageService;

@MultipartConfig
@WebServlet("/auth/*")
public class AuthController extends HttpServlet {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("ticketflow");
    UserDAO dao;
    private Dotenv dotenv;
    private Cloudinary cloudinary;
    private ImageService imageService;

    @Override
    public void init() throws ServletException {
        super.init();
        dotenv = Dotenv.load();
        cloudinary = new Cloudinary(dotenv.get("CLOUDINARY_URL"));
        dao = new UserDAO(emf);
        imageService = new ImageService(cloudinary);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getRequestURI();
        switch (path.substring(path.lastIndexOf("/") + 1, path.length())) {
            case "logout":
                logout(req, resp);
                break;

            case "delete": 
                delete(req, resp);
                break;

            case "list": 
                list(req, resp);
                break;

            case "find":
                find(req, resp);
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
            case "register":
                registerUser(req, resp);
                break;
            
            case "login":
                login(req, resp);
                break;
            
            default:
                System.out.println("Error! Request not found!");
                break;
        }
    }

    private void registerUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        Part userImage = req.getPart("foto");
        Role role = Role.valueOf(req.getParameter("role"));
        String url = imageService.uploadPart(userImage, username);
        
        if (dao.findByUsername(username) != null || dao.findByEmail(email) != null) {
            req.setAttribute("error", true);
            req.getRequestDispatcher("/cadastroUsuario.jsp").forward(req, resp);
        } else {
            User user = new User(username, email, password, role, url);
            boolean status = dao.insert(user);

            req.setAttribute("status", status);
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
    
    private void login(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        
        User user = dao.findByUsername(username);
        
        if(user != null && Encryptor.verifyPassword(password, user.getPassword())) {
            HttpSession session = req.getSession();
			session.setAttribute("user", user);
            session.setMaxInactiveInterval(60*60*24*7);
			
			req.getRequestDispatcher("/tickets.jsp").forward(req, resp);
		}
		else {
            req.setAttribute("error", true);
			req.getRequestDispatcher("/login.jsp").forward(req, resp);
		}
    }
    
    private void logout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
		session.invalidate();
		req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }
    
    private void find(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");

        User user = dao.findByUsername(username);
        
        req.setAttribute("user", user);
        req.getRequestDispatcher("/tickets.jsp").forward(req, resp);
    }

    private void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        ArrayList<User> listUsers = dao.getAll();
        
        req.setAttribute("listUsers", listUsers);
        req.getRequestDispatcher("/tickets.jsp").forward(req, resp);
    }
        
    private void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");

        User user = dao.findById(id);

        boolean status = dao.delete(user);
        req.setAttribute("status", status);
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }
}
