package com.example.EventManager.repos;

import com.example.EventManager.domain.TwitBoardMessage;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TwitBoardMessageRepo extends JpaRepository<TwitBoardMessage, Long> {
    TwitBoardMessage findByid(Long id);
}
