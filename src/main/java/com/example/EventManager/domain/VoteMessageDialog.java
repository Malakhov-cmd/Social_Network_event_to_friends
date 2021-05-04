package com.example.EventManager.domain;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class VoteMessageDialog {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer id;

    private User currentUser;

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = false)
    @JoinColumn(name = "vote_message_dialog_mes_id")
    @ElementCollection
    private List<VoteMessageDialogMes> dialogMessageList = new ArrayList<>();

    public VoteMessageDialog() {}

    public VoteMessageDialog(User currentUser) {
        this.currentUser = currentUser;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public User getCurrentUser() {
        return currentUser;
    }

    public void setCurrentUser(User currentUser) {
        this.currentUser = currentUser;
    }

    public List<VoteMessageDialogMes> getDialogMessageList() {
        return dialogMessageList;
    }

    public void setDialogMessageList(List<VoteMessageDialogMes> dialogMessageList) {
        this.dialogMessageList = dialogMessageList;
    }
}
