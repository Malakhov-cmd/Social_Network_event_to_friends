package com.example.EventManager.domain;

import org.hibernate.validator.constraints.Length;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;

@Entity
public class Message {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer id;

    @NotBlank(message = "Please, enter header to message")
    private String header;

    @NotBlank(message = "Please, enter header to message")
    private String theme;

    @NotBlank(message = "Please, enter header to message")
    @Length(max = 2048, message = "Message too long")
    private String text;

    private String date;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private User author;

    private String filename;

    @NotBlank(message = "Please, choose activity type")
    private String activityType;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "votemessage_id")
    private VoteMessage voteMessage;

    @OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "room_to_message")
    private Room room;

    public Message(){
    }

    public Message(String header, String theme, String activityType, String text, User author) {
        this.header = header;
        this.theme = theme;
        this.text = text;
        this.activityType = activityType;
        this.author = author;
    }

    public String getActivityType() {
        return activityType;
    }

    public void setActivityType(String activityType) {
        this.activityType = activityType;
    }

    public String getAuthorName(){
        return author != null ? author.getUsername() : "<none>";
    }

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getHeader() {
        return header;
    }

    public void setHeader(String header) {
        this.header = header;
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

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public VoteMessage getVoteMessage() {
        return voteMessage;
    }

    public void setVoteMessage(VoteMessage voteMessage) {
        this.voteMessage = voteMessage;
    }
}
