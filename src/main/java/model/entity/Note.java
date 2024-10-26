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
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Note {
    @Id
    private String id;
    @NotBlank
    private String text;
    @CreationTimestamp
    private Instant send;
    @UpdateTimestamp
    private Instant updated;
    @NotNull
    @ManyToOne(optional = false)
    private User poster;
    @NotNull
    @ManyToOne(optional = false)
    private Ticket ticket;

    public Note(@NotBlank String text, @NotNull User poster, @NotNull Ticket ticket) {
        this.text = text;
        this.poster = poster;
        this.ticket = ticket;
    }
}
