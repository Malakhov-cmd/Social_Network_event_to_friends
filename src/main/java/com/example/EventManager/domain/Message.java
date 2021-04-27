package com.example.EventManager.domain;

import javax.persistence.*;
import java.sql.Date;

@Entity
public class Message {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer id;

    private String header;
    private String theme;
    private String text;
    private String date;
    //показываем каким образом все будет обображаться в базе данных и подгружаем всю информацию о пользователе
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id")
    private User author;

    public Message(){
    }

    public Message(String header, String theme, String text, String date, User author) {
        this.header = header;
        this.theme = theme;
        this.text = text;
        this.date = date;
        this.author = author;
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
}
