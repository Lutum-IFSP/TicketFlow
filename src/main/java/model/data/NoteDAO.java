package model.data;

import java.util.ArrayList;
import java.util.UUID;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.OrderBy;
import javax.persistence.Query;

import model.entity.Note;
import model.entity.Ticket;

public class NoteDAO {
    private EntityManagerFactory emf;

    public NoteDAO(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public boolean insert(Note note) {
        EntityManager em = emf.createEntityManager();
        note.setId(UUID.randomUUID().toString());

        try {
            em.getTransaction().begin();
            em.persist(note);
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
    public ArrayList<Note> getAll(Ticket ticket) {
        ArrayList<Note> notes = new ArrayList<>();
        EntityManager em = emf.createEntityManager();

        try {
            Query query = em.createQuery(String.format("from %s where ticket = :t order by send asc", Note.class.getName()));
            query.setParameter("t", ticket);
            notes = (ArrayList<Note>) query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }

        return notes;
    }

    public Note findById(String id) {
        EntityManager em = emf.createEntityManager();
        Note note = null;

        try {
            note = em.find(Note.class, id);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            em.close();
        }

        return note;
    }

    public boolean update(Note note) {
        EntityManager em = emf.createEntityManager();
        
        try {
            em.getTransaction().begin();
            em.merge(note);
            em.getTransaction().commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }

    public boolean remove(Note note) {
        EntityManager em = emf.createEntityManager();
        
        try {
            em.getTransaction().begin();
            em.remove(note);
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
