package com.example.EventManager.domain;

import org.hibernate.annotations.Cascade;

import javax.persistence.*;
import java.util.Collections;
import java.util.List;

@Entity
public class Dialog {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer id;

    private User firstUser;
    private User secondUser;

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = false)
    @JoinColumn(name = "dialog_id")
    @ElementCollection
    private List<DialogMessage> dialogMessageList;

    public Dialog(){}

    public Dialog(User firstUser, User secondUser, List<DialogMessage> dialogMessageList) {
        this.firstUser = firstUser;
        this.secondUser = secondUser;
        this.dialogMessageList = dialogMessageList;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public User getFirstUser() {
        return firstUser;
    }

    public void setFirstUser(User firstUser) {
        this.firstUser = firstUser;
    }

    public User getSecondUser() {
        return secondUser;
    }

    public void setSecondUser(User secondUser) {
        this.secondUser = secondUser;
    }

    public List<DialogMessage> getDialogMessageList() {
        Collections.sort( dialogMessageList, DialogMessage.CompareByDate);
        return dialogMessageList;
    }

    public void setDialogMessageList(List<DialogMessage> dialogMessageList) {
        this.dialogMessageList = dialogMessageList;
    }
}
