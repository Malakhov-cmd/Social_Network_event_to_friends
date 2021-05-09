package com.example.EventManager.repos;

import com.example.EventManager.domain.Room;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoomRepo extends JpaRepository<Room, Long> {
    Room findByid(Integer id);
    Room findByRoomName(String roomName);
}
