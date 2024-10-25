package model.entity;

import java.time.Instant;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.validation.constraints.NotBlank;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import model.enums.Priority;
import model.enums.Stage;

@Entity
@Data
@AllArgsConstructor
public class Ticket {
    @Id
    private String id;
    @NotBlank
    private String title;
    private String tags;
    @Enumerated(EnumType.STRING)
    private Stage stage;
    @Enumerated(EnumType.STRING)
    private Priority priority;
    @CreationTimestamp
    private Instant created;
    @UpdateTimestamp
    private Instant updated;
    private Instant closed;
    @ManyToOne(optional = false)
    @NotBlank
    private User user;
    
    public Ticket(@NotBlank String title, String tags, Stage stage, Priority priority, @NotBlank User user) {
        this.title = title;
        this.tags = tags;
        this.stage = stage;
        this.priority = priority;
        this.user = user;
    }
}
