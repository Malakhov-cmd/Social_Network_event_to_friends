package com.example.EventManager.domain;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "room_message")
public class Room implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(name = "room_message_admin_room")
    private User admin;

    @Column(name = "room_name")
    private String roomName;

    @ManyToMany(cascade = CascadeType.ALL)
    @JoinColumn(name = "room_message_participant_room")
    @ElementCollection
    private List<User> participants = new ArrayList<>();

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = false)
    @JoinColumn(name = "room_message_mess_room")
    @ElementCollection
    private List<Message> roomMessage = new ArrayList<>();

    public Room() {}

    public Room(User admin, String roomName)
    {
        this.admin = admin;
        this.roomName = roomName;
        participants.add(admin);
    }

    public String getRoomName() {
        return roomName;
    }

    public Long getId() {
        return id;
    }

    public User getAdmin() {
        return admin;
    }

    public void setAdmin(User admin) {
        this.admin = admin;
    }

    public List<User> getParticipants() {
        return participants;
    }

    public void setParticipants(List<User> participants) {
        this.participants = participants;
    }

    public List<Message> getRoomMessage() {
        return roomMessage;
    }

    public void setRoomMessage(List<Message> roomMessage) {
        this.roomMessage = roomMessage;
    }
}
