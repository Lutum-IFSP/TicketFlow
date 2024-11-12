package model.data;

import java.util.ArrayList;
import java.util.UUID;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.NoResultException;
import javax.persistence.OrderBy;
import javax.persistence.Query;

import model.entity.Note;
import model.entity.Ticket;
import model.entity.User;
import model.enums.Priority;
import model.enums.Stage;

public class TicketDAO {
    private EntityManagerFactory emf;

    public TicketDAO(EntityManagerFactory emf) {
        super();
        this.emf = emf;
    }

    public boolean insert(Ticket ticket) {
        EntityManager em = emf.createEntityManager();
        ticket.setId(UUID.randomUUID().toString());

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

    public boolean remove(String id) {
        EntityManager em = emf.createEntityManager();

        try {
            Ticket ticket = em.find(Ticket.class, id);
            em.getTransaction().begin();
            em.remove(ticket);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
    public boolean update(Ticket ticket) {
        EntityManager em = emf.createEntityManager();

        try {
            em.getTransaction().begin();
            em.merge(ticket);
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
    @OrderBy("priority DESC")
    public ArrayList<Ticket> getAll() {
        EntityManager em = emf.createEntityManager();
        ArrayList<Ticket> listTickets = new ArrayList<Ticket>();

        try {
            Query query = em.createQuery("from " + Ticket.class.getName());		
			listTickets = (ArrayList<Ticket>) query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }

        return listTickets;
    }

    @SuppressWarnings("unchecked")
    public ArrayList<Ticket> getByPriority(Priority priority) {
        EntityManager em = emf.createEntityManager();
        ArrayList<Ticket> listTickets = new ArrayList<Ticket>();

        try {
            Query query = em.createQuery("from " + Ticket.class.getName() + " where priority = :p");
            query.setParameter("p", priority);		
			listTickets = (ArrayList<Ticket>) query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }

        return listTickets;
    }

    @SuppressWarnings("unchecked")
    @OrderBy("priority DESC")
    public ArrayList<Ticket> getByUser(User user) {
        EntityManager em = emf.createEntityManager();
        ArrayList<Ticket> listTickets = new ArrayList<Ticket>();

        try {
            Query query = em.createQuery("from " + Ticket.class.getName() + " where user = :u");	
            query.setParameter("u", user);	
			listTickets = (ArrayList<Ticket>) query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }

        return listTickets;
    }

    @SuppressWarnings("unchecked")
    @OrderBy("priority DESC")
    public ArrayList<Ticket> getByUserAndStage(User user, Stage stage) {
        EntityManager em = emf.createEntityManager();
        ArrayList<Ticket> listTickets = new ArrayList<Ticket>();

        try {
            Query query = em.createQuery("from " + Ticket.class.getName() + " where user = :u and stage = :s");	
            query.setParameter("u", user);	
            query.setParameter("s", stage);	
			listTickets = (ArrayList<Ticket>) query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }

        return listTickets;
    }
    
    @SuppressWarnings("unchecked")
    public ArrayList<Ticket> getByUserAndStage(User user, Stage stage) {
        EntityManager em = emf.createEntityManager();
        ArrayList<Ticket> listTickets = new ArrayList<Ticket>();
    
        try {
            Query query = em.createQuery("from " + Ticket.class.getName() + " where user = :u and stage = :s");	
            query.setParameter("u", user);
            query.setParameter("s", stage);
            listTickets = (ArrayList<Ticket>) query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }
    
        return listTickets;
    }

    public Ticket getById(String id) {
        EntityManager em = emf.createEntityManager();
        Ticket ticket = null;

        try {
            ticket = em.find(Ticket.class, id);
        } catch (Exception e) {
            e.printStackTrace(); 
        } finally {
            em.close();
        }

        return ticket;
    }
}
