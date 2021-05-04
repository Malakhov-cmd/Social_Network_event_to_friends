package com.example.EventManager.domain;

import org.hibernate.annotations.Cascade;

import javax.persistence.*;

@Entity
@Table(name = "vote_mess_dialog_mes")
public class VoteMessageDialogMes {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    @Column(name = "id")
    private Integer id;

    @Column(name = "vote_mess_usr_author")
    @Cascade(org.hibernate.annotations.CascadeType.ALL)
    private User author;

    @Column(name = "vote_mess_date_recived")
    private String date;

    @Column(name = "vote_mes_txt")
    private String text;

    public VoteMessageDialogMes(){}

    public VoteMessageDialogMes(User author) {
        this.author = author;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public User getAuthor() {
        return author;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }
}
