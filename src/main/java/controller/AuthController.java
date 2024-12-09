package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.json.JSONArray;
import org.json.JSONObject;

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
@WebServlet({"/auth/*", "/user/*"})
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

            case "empty":
                verifyEmpty(req, resp);
                break;

            case "verify": 
                verify(req, resp);
                break;

            case "search":
                searchUsers(req, resp);
                break;

            case "exists":
                exists(req, resp);
                break;

            default:
                System.out.println("GAuthError: Error! Request not found!");
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

            case "changepassword":
                changePassword(req, resp);
                break;

            case "update":
                update(req, resp);
                break;

            case "edit":
                edit(req, resp);
                break;

            default:
                System.out.println("PAuthError: Error! Request not found!");
                break;
        }
    }

    private void searchUsers(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String searchTerm = req.getParameter("q");

        searchTerm = searchTerm.replace("\"", "");

        ArrayList<User> users = dao.searchByUsername(searchTerm);

        JSONArray array = new JSONArray();
        for (User user : users) {
            if (user.getRole() != Role.ADMIN || (User) session.getAttribute("user") != null) {
                if (((User) session.getAttribute("user")).getRole() == Role.ADMIN) {
                    JSONObject object = new JSONObject();
                    object.put("id", user.getId());
                    object.put("username", user.getUsername());
                    object.put("email", user.getEmail());
                    object.put("role", user.getRole());
                    object.put("image", user.getImage());
                    array.put(object);
                }
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
                
    private void registerUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        Part userImage = req.getPart("foto");
        Role role = Role.valueOf(req.getParameter("role"));
        String url = imageService.uploadPart(userImage, username);
        
        if (dao.findByUsername(username) != null || dao.findByEmail(email) != null) {
            req.setAttribute("error", true);
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        } else {
            User user = new User(username, email, password, role, url);
            boolean status = dao.insert(user);

            req.setAttribute("status", status);
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }
    
    private void changePassword(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String newPassword = req.getParameter("password");
        User user = (User) req.getSession().getAttribute("user");

        newPassword = Encryptor.encrypt(newPassword);
        user.setPassword(newPassword);

        boolean status = dao.update(user);

        req.setAttribute("status", status);
        req.getRequestDispatcher("/settings.jsp").forward(req, resp);
    }
    
    private void login(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        
        User user = dao.findByUsername(username);
        
        if(user != null && Encryptor.verifyPassword(password, user.getPassword())) {
            HttpSession session = req.getSession();
			session.setAttribute("user", user);
            session.setMaxInactiveInterval(60*60*24*7);
			
            resp.sendRedirect(req.getContextPath() + "/ticket/list");
		} else {
            req.setAttribute("error", true);
			req.getRequestDispatcher("/login.jsp").forward(req, resp);
		}
    }
    
    private void logout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
		session.invalidate();
		req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    private void verify(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        String password = req.getParameter("old-password");

        password = password.replace("\"", "");

        boolean verified = (Encryptor.verifyPassword(password, user.getPassword())) ? true : false;

        JSONObject obj = new JSONObject();
        obj.put("verified", verified);

        PrintWriter out = resp.getWriter();
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        out.println(obj.toString());
        out.flush();
    }

    private void exists(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");

        username = username.replace("\"", "");

        boolean verified = (dao.findByUsername(username) == null) ? true : false;

        JSONObject obj = new JSONObject();
        obj.put("verified", verified);

        PrintWriter out = resp.getWriter();
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        out.println(obj.toString());
        out.flush();
    }
    
    private void find(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");

        User user = dao.findByUsername(username);
        
        req.setAttribute("user", user);
        req.getRequestDispatcher("/tickets.jsp").forward(req, resp);
    }

    private void verifyEmpty(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = dao.findByUsername("admin");

        if (user == null) {
            User admin = new User("admin", "admin@admin", "admin", Role.ADMIN, "image/user.png");
            dao.insert(admin);
        }
        user = null;

        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    private void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        ArrayList<User> listUsers = dao.getAll();
        
        req.setAttribute("listUsers", listUsers);
        req.getRequestDispatcher("/tickets.jsp").forward(req, resp);
    }

    private void edit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        Role role = Role.valueOf(req.getParameter("role-editarUser"));
        Part image = req.getPart("image");
        String url = "";

        if (!image.getSubmittedFileName().isEmpty()) {
            url = imageService.uploadPart(image, username);
        }

        User user = dao.findById(id);
        user.setUsername(username);
        user.setEmail(email);
        user.setRole(role);
        if(!url.isEmpty()) {
            user.setImage(url);
        }
        dao.update(user);

        resp.sendRedirect(req.getContextPath() + "/settings.jsp?crud=1");
    }

    private void update(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String email = req.getParameter("email");
        Part image = req.getPart("image");
        String url = "";

        if (!image.getSubmittedFileName().isEmpty()) {
            url = imageService.uploadPart(image, username);
        }

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        user.setUsername(username);
        user.setEmail(email);
        if(!url.isEmpty()) {
            user.setImage(url);
        }
        dao.update(user);

        resp.sendRedirect(req.getContextPath() + "/settings.jsp?user=1");
    }
        
    private void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");

        User user = dao.findById(id);

        boolean status = dao.delete(user);
        req.setAttribute("status", status);
        req.getRequestDispatcher("/settings.jsp").forward(req, resp);
    }
}
