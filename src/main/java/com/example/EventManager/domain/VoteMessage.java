package com.example.EventManager.domain;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class VoteMessage {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer id;

    private User author;

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = false)
    @JoinColumn(name = "voteMessage_id")
    @ElementCollection
    private List<Vote> votedUsers = new ArrayList<>();

    public VoteMessage() {}

    public VoteMessage(User author)
    {
        this.author = author;
    }

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    public List<Vote> getVotedUsers() {
        return votedUsers;
    }

    public void setVotedUsers(List<Vote> votedUsers) {
        this.votedUsers = votedUsers;
    }
}
