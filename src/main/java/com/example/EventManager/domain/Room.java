package com.example.EventManager.domain;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "room_message")
public class Room {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @Column(name = "admin_room")
    private User admin;

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = false)
    @JoinColumn(name = "participant_room")
    @ElementCollection
    private List<User> participants = new ArrayList<>();

    @OneToMany(cascade = CascadeType.ALL, orphanRemoval = false)
    @JoinColumn(name = "mess_room")
    @ElementCollection
    private List<Message> roomMessage = new ArrayList<>();

    public Room() {}

    public Room(User admin)
    {
        this.admin = admin;
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
