package com.example.EventManager.repos;

import com.example.EventManager.domain.VoteMessageDialog;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VoteMessageDialogRepo extends JpaRepository<VoteMessageDialog, Long> {
    VoteMessageDialog findById(Integer id);
}
