package model.entity;

import java.time.Instant;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.Id;
import javax.validation.constraints.NotBlank;

import org.hibernate.annotations.CreationTimestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import model.enums.Role;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User {
    @Id
    private String id;
    @NotBlank
    private String username;
    @NotBlank
    private String email;
    @NotBlank
    private String password;

    @Enumerated(EnumType.STRING)
    private Role role;

    @CreationTimestamp
    private Instant created;

    public User(@NotBlank String username, @NotBlank String email, @NotBlank String password, Role role) {
        this.username = username;
        this.email = email;
        this.password = password;
        this.role = role;
    }
}
