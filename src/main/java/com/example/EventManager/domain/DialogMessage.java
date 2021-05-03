package com.example.EventManager.domain;

import org.hibernate.annotations.Cascade;

import javax.persistence.*;
import java.sql.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.util.Comparator;

@Entity
@Table(name = "dialog_Mes")
public class DialogMessage {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    @Column(name = "id")
    private Integer id;

    @Column(name = "usr_from")
    @Cascade(org.hibernate.annotations.CascadeType.ALL)
    private User from;

    @Column(name = "usr_to")
    @Cascade(org.hibernate.annotations.CascadeType.ALL)
    private User to;

    @Column(name = "date_recived")
    private String date;

    @Column(name = "mes_txt")
    private String text;

    public DialogMessage(){}

    public DialogMessage(User from, User to, String text) {
        this.from = from;
        this.to = to;
        this.text = text;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public User getFrom() {
        return from;
    }

    public Long getFromId() {return from.getId();}

    public void setFrom(User from) {
        this.from = from;
    }

    public User getTo() {
        return to;
    }

    public void setTo(User to) {
        this.to = to;
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

    public static final Comparator<DialogMessage> CompareByDate = new Comparator<DialogMessage>() {
        @Override
        public int compare(DialogMessage o1, DialogMessage o2) {
            return o1.getId() - o2.getId();
        }
    };
}
