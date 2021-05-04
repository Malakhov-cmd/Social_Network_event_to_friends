package com.example.EventManager.domain;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class VoteMessage {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    private Integer id;

    @Column(name = "message_author")
    private User author;

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = false)
    @JoinColumn(name = "vote_message_id")
    @ElementCollection
    private List<Vote> votedUsers = new ArrayList<>();

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = false)
    @JoinColumn(name = "vote_message_dialog_id")
    @ElementCollection
    private VoteMessageDialog voteMessageDialog;

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

    public VoteMessageDialog getVoteMessageDialog() {
        return voteMessageDialog;
    }

    public void setVoteMessageDialog(VoteMessageDialog voteMessageDialog) {
        this.voteMessageDialog = voteMessageDialog;
    }

    public List<Vote> getVoteAgree()
    {
        List<Vote> voteList = new ArrayList<>();
        for (Vote vote:
             votedUsers) {
            if (vote.getDecision().equals("Agree"))
            {
                System.out.println("CHECK: success ");
                voteList.add(vote);
            }
        }
        return voteList;
    }

    public List<Vote> getVoteAgainst()
    {
        List<Vote> voteList = new ArrayList<>();
        for (Vote vote:
                votedUsers) {
            if (vote.getDecision().equals("Against"))
            {
                voteList.add(vote);
            }
        }
        return voteList;
    }

    public List<Vote> getVoteAbstain()
    {
        List<Vote> voteList = new ArrayList<>();
        for (Vote vote:
                votedUsers) {
            if (vote.getDecision().equals("Abstain"))
            {
                voteList.add(vote);
            }
        }
        return voteList;
    }
}
