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
    @CreationTimestamp
    private Instant created;
    @UpdateTimestamp
    private Instant updated;
    private Instant closed;
    @ManyToOne(optional = false)
    @NotBlank
    private User user;
}
