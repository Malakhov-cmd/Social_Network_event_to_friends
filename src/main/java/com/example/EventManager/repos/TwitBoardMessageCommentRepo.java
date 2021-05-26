package com.example.EventManager.repos;

import com.example.EventManager.domain.TwitBoardMessageComment;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TwitBoardMessageCommentRepo extends JpaRepository<TwitBoardMessageComment, Long> {
    TwitBoardMessageComment findByid(Long id);
}
