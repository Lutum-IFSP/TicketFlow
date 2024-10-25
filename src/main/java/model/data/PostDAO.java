package model.data;

import java.util.ArrayList;
import java.util.UUID;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;

import model.entity.Post;
import model.entity.Ticket;

public class PostDAO {
    private EntityManagerFactory emf;

    public PostDAO(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public boolean insert(Post post) {
        EntityManager em = emf.createEntityManager();
        post.setId(UUID.randomUUID().toString());

        try {
            em.getTransaction().begin();
            em.persist(post);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    @SuppressWarnings("unchecked")
    public ArrayList<Post> getAll(Ticket ticket) {
        ArrayList<Post> posts = new ArrayList<>();
        EntityManager em = emf.createEntityManager();

        try {
            Query query = em.createQuery(String.format("from %s where ticket = :t", Post.class.getName()));
            query.setParameter("t", ticket);
            posts = (ArrayList<Post>) query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }

        return posts;
    }

    public Post findById(String id) {
        EntityManager em = emf.createEntityManager();
        Post post = null;

        try {
            post = em.find(Post.class, id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }

        return post;
    }

    public boolean update(Post post) {
        EntityManager em = emf.createEntityManager();
        
        try {
            em.getTransaction().begin();
            em.merge(post);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    public boolean remove(Post post) {
        EntityManager em = emf.createEntityManager();
        
        try {
            em.getTransaction().begin();
            em.remove(post);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
}
