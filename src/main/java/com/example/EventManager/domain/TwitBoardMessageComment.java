package com.example.EventManager.domain;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

@Entity
@Table(name = "twit_brd_message_comment")
public class TwitBoardMessageComment {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(name = "twit_board_message_comment_author")
    private User authorComment;

    @Column(name = "twit_board_message_comment_text")
    @NotBlank(message = "Please, enter text")
    private String textComment;

    @Column(name = "twit_board_message_comment_date")
    private String dateComment;

    @Column(name = "twit_board_message_comment_filename")
    private String filename;

    @ManyToMany
    @JoinTable(
            name = "twit_board_mes_comments_likes",
            joinColumns = {@JoinColumn(name = "wit_board_message_comment_likes")}
    )
    private List<User> likesListComment = new ArrayList<>();

    public TwitBoardMessageComment() {}

    public TwitBoardMessageComment(User authorComment, String textComment) {
        this.authorComment = authorComment;
        this.textComment = textComment;
    }

    public int getCommentLikesCount(){
        return likesListComment.size();
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getAuthorComment() {
        return authorComment;
    }

    public void setAuthorComment(User authorComment) {
        this.authorComment = authorComment;
    }

    public String getTextComment() {
        return textComment;
    }

    public void setTextComment(String textComment) {
        this.textComment = textComment;
    }

    public String getDateComment() {
        return dateComment;
    }

    public void setDateComment(String dateComment) {
        this.dateComment = dateComment;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public List<User> getLikesListComment() {
        return likesListComment;
    }

    public void setLikesListComment(List<User> likesListComment) {
        this.likesListComment = likesListComment;
    }

    public Long getAuthorId() {
        return authorComment.getId();
    }

    public static final Comparator<TwitBoardMessageComment> CompareTwitsCommentsByDate = new Comparator<TwitBoardMessageComment>() {
        @Override
        public int compare(TwitBoardMessageComment o1, TwitBoardMessageComment o2) {
            return (int) (o1.getId() - o2.getId());
        }
    };
}
