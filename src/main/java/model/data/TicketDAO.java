package model.data;

import java.util.ArrayList;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;

import model.entity.Ticket;

public class TicketDAO {
    private EntityManagerFactory emf;

    public TicketDAO(EntityManagerFactory emf) {
        super();
        this.emf = emf;
    }

    public boolean insert(Ticket ticket) {
        EntityManager em = emf.createEntityManager();

        try {
            em.getTransaction().begin();
            em.persist(ticket);
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
    public ArrayList<Ticket> searchByTitle(String title) {
        EntityManager em = emf.createEntityManager();
        ArrayList<Ticket> tickets = new ArrayList<>();

        try {
            Query query = em.createQuery(String.format("from %s where title ~ \"*:t*\"", Ticket.class.getName()));
            query.setParameter("t", title);
            tickets = (ArrayList<Ticket>) query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }

        return tickets;
    }

    public Ticket searchById(String id) {
        EntityManager em = emf.createEntityManager();
        Ticket ticket = null;

        try {
            em.find(Ticket.class, id);    
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }

        return ticket;
    }
}
