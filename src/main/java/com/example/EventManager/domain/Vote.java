package com.example.EventManager.domain;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "vote")
public class Vote {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    @Column(name = "id")
    private Integer id;

    @Column(name = "voted_usr")
    private User user;

    @Column(name = "option_list")
    @ElementCollection
    private List<String> option;

    @Column(name = "final_voted")
    private String decision;

    @Column(name = "description")
    private String description;

    @Column(name = "date_voted")
    private String date;

    public Vote(User user) {
        this.user = user;
        //option.add("Agree");
        //option.add("Against");
        //option.add("Abstain");
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getDecision() {
        return decision;
    }

    public void setDecision(String decision) {
        this.decision = decision;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
}
