package com.example.EventManager.repos;

import com.example.EventManager.domain.Vote;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VoteRepo extends JpaRepository<Vote, Long> {
}
