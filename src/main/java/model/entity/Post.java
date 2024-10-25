package model.entity;

import java.time.Instant;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import lombok.AllArgsConstructor;
import lombok.Data;

@Entity
@Data
@AllArgsConstructor
public class Post {
    @Id
    private String id;
    @NotBlank
    private String text;
    @CreationTimestamp
    private Instant send;
    @UpdateTimestamp
    private Instant update;
    @NotNull
    @ManyToOne(optional = false)
    private User poster;
    @NotNull
    @ManyToOne(optional = false)
    private Ticket ticket;

    public Post(@NotBlank String text, @NotNull User poster, @NotNull Ticket ticket) {
        this.text = text;
        this.poster = poster;
        this.ticket = ticket;
    }
}
