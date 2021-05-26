package com.example.EventManager.domain;


import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "twit_brd")
public class TwitBoard {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(name = "twit_board_owner")
    private User owner;

    @ManyToMany
    @JoinTable(
            name = "twit_board_mes_list",
            joinColumns = { @JoinColumn(name = "twits_on_board") }
    )
    private List<TwitBoardMessage> twitBoardMessageList = new ArrayList<>();

    public TwitBoard() {}

    public TwitBoard(User owner) {
        this.owner = owner;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getOwner() {
        return owner;
    }

    public void setOwner(User owner) {
        this.owner = owner;
    }

    public List<TwitBoardMessage> getTwitBoardMessageList() {
        return twitBoardMessageList;
    }

    public void setTwitBoardMessageList(List<TwitBoardMessage> twitBoardMessageList) {
        this.twitBoardMessageList = twitBoardMessageList;
    }
}
