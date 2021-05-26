package com.example.EventManager.repos;

import com.example.EventManager.domain.TwitBoard;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TwitBoardRepo extends JpaRepository<TwitBoard, Long> {
    TwitBoard findByid(Long id);
}
