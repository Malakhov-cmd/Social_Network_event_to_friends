package com.example.EventManager.repos;

import com.example.EventManager.domain.VoteMessageDialogMes;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VoteMessageDialogMesRepo extends JpaRepository<VoteMessageDialogMes, Long> {
    VoteMessageDialogMes findById(Integer id);
}
