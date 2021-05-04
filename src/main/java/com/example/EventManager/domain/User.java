package com.example.EventManager.domain;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "usr")
public class User implements UserDetails {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    private String username;
    private String password;
    private boolean isActive;

    private String avatarFilename;

    @ElementCollection(targetClass = Role.class, fetch = FetchType.EAGER)
    @CollectionTable(name = "user_role", joinColumns = @JoinColumn(name = "user_id"))
    @Enumerated(EnumType.STRING)
    private Set<Role> roles;

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = false)
    @JoinColumn(name = "user_dialog_id")
    @ElementCollection
    private List<Dialog> dialogList;

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = false, fetch = FetchType.EAGER)
    @JoinColumn(name = "user_votemessage_id")
    @ElementCollection
    private List<VoteMessage> voteMessages = new ArrayList<>();

    public User(){}

    public boolean hasAvatar()
    {
        if(avatarFilename == "" || avatarFilename.isEmpty())
        {
            return false;
        }
        return true;
    }

    public Integer getIdDialog(User first, User second)
    {
        for(Dialog dialog : dialogList)
        {
            if(dialog.getFirstUser().getId().equals(first.getId())
                    && dialog.getSecondUser().getId().equals(second.getId()))
            {
                return dialog.getId();
            }
        }
        return -1;
    }

    public boolean isAdmin()
    {
        return getRoles().contains(Role.ADMIN);
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getAvatarFilename() {
        return avatarFilename;
    }

    public void setAvatarFilename(String avatarFilename) {
        this.avatarFilename = avatarFilename;
    }

    public String getUsername() {
        return username;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return isActive();
    }

    public void setUsername(String username) {
        this.username = username;
    }

    //статус аккаунта пользователь админ модератор
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return getRoles();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }

    public List<Dialog> getDialogList() {
        return dialogList;
    }

    public void setDialogList(List<Dialog> dialogList) {
        this.dialogList = dialogList;
    }

    public List<VoteMessage> getVoteMessages() {
        return voteMessages;
    }

    public void setVoteMessages(List<VoteMessage> voteMessages) {
        this.voteMessages = voteMessages;
    }
}
