package model.data;

import java.util.ArrayList;
import java.util.UUID;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;

import at.favre.lib.crypto.bcrypt.BCrypt;
import model.entity.User;

public class UserDAO {
    private EntityManagerFactory emf;

    public UserDAO(EntityManagerFactory emf) {
        super();
        this.emf = emf;
    }

    public boolean insert(User user) {
        String password = BCrypt.withDefaults().hashToString(14, user.getPassword().toCharArray());
        user.setPassword(password);
        user.setId(UUID.randomUUID().toString());
        EntityManager em = emf.createEntityManager();

        try {
            em.getTransaction().begin();
            em.persist(user);
            em.getTransaction().commit();

            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;

        } finally {
            em.close();
            
        }
    }

    public boolean delete(User user) {
        EntityManager em = emf.createEntityManager();
			
		try {
			em.getTransaction().begin();
			em.remove(user);
			em.getTransaction().commit();
			return true;

		}
		catch (Exception e) {
			e.printStackTrace();
			return false;

		}
		finally {
			em.close();

		}
    }

    @SuppressWarnings("unchecked")
    public ArrayList<User> getAll() {
        EntityManager em = emf.createEntityManager();
        ArrayList<User> listUsers = new ArrayList<User>();

        try {
            Query query = em.createQuery("from " + User.class.getName());		
			listUsers = (ArrayList<User>) query.getResultList();

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            em.close();

        }

        return listUsers;
    }

    public User findById(String id) {
        EntityManager em = emf.createEntityManager();
        User user = null;

        try {
            user = em.find(User.class, id);

        } catch (Exception e) {
            e.printStackTrace();
            
        } finally {
            em.close();

        }

        return user;
    }

    public User findByUsername(String username) {
        EntityManager em = emf.createEntityManager();
        User user = null;
        
        try {
            Query query = em.createQuery("from " + User.class.getName() + " where username = :u");
            query.setParameter("u", username);
            user = (User) query.getSingleResult();

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            em.close();

        }

        return user;
    }

    public User findByEmail(String email) {
        EntityManager em = emf.createEntityManager();
        User user = null;
        
        try {
            Query query = em.createQuery("from " + User.class.getName() + " where email = :e");
            query.setParameter("e", email);
            user = (User) query.getSingleResult();

        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            em.close();

        }

        return user;
    }
}
