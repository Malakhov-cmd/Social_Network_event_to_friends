package com.example.EventManager.domain;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "twit_brd_message")
public class TwitBoardMessage {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(name = "uuid_rnd_1")
    private String uuid1;

    @Column(name = "uuid_rnd_2")
    private String uuid2;

    @Column(name = "twit_board_message_author")
    private User author;

    @Column(name = "twit_board_message_theme")
    @NotBlank(message = "Please, enter theme")
    private String theme;

    @Column(name = "twit_board_message_text")
    @NotBlank(message = "Please, enter text to your twit")
    private String text;

    @Column(name = "twit_board_message_date")
    private String date;

    @Column(name = "twit_board_message_filename")
    private String filename;

    @ManyToMany
    @JoinTable(
            name = "twit_board_mes_likes",
            joinColumns = { @JoinColumn(name = "twit_board_message_likes")}
    )
    private List<User> likesList = new ArrayList<>();

    @ManyToMany
    @JoinTable(
            name = "twit_board_mes_comments",
            joinColumns = {@JoinColumn(name = "twit_brd_message_comments")}
    )
    private List<TwitBoardMessageComment> twitBoardMessageComments = new ArrayList<>();

    public TwitBoardMessage() {}

    public TwitBoardMessage(User author, String theme, String text) {
        this.author = author;
        this.theme = theme;
        this.text = text;
        uuid1 = UUID.randomUUID().toString();
        uuid2 = UUID.randomUUID().toString();
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUuid1() {
        return uuid1;
    }

    public void setUuid1(String uuid1) {
        this.uuid1 = uuid1;
    }

    public String getUuid2() {
        return uuid2;
    }

    public void setUuid2(String uuid2) {
        this.uuid2 = uuid2;
    }

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    public String getTheme() {
        return theme;
    }

    public void setTheme(String theme) {
        this.theme = theme;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public List<User> getLikesList() {
        return likesList;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public void setLikesList(List<User> likesList) {
        this.likesList = likesList;
    }

    public int getLikesCount(){
        return likesList.size();
    }

    public Long getIdAuthor()
    {
        return author.getId();
    }

    public List<TwitBoardMessageComment> getTwitBoardMessageComments() {
        return twitBoardMessageComments;
    }

    public void setTwitBoardMessageComments(List<TwitBoardMessageComment> twitBoardMessageComments) {
        this.twitBoardMessageComments = twitBoardMessageComments;
    }

    public static final Comparator<TwitBoardMessage> CompareTwitsByDate = new Comparator<TwitBoardMessage>() {
        @Override
        public int compare(TwitBoardMessage o1, TwitBoardMessage o2) {
            return (int) (o1.getId() - o2.getId());
        }
    };
}
