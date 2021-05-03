package com.example.EventManager.repos;

import com.example.EventManager.domain.VoteMessage;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VoteMessageRepo extends JpaRepository<VoteMessage, Long> {
}
