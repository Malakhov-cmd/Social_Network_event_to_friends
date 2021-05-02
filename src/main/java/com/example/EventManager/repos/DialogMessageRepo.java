package com.example.EventManager.repos;

import com.example.EventManager.domain.DialogMessage;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DialogMessageRepo extends JpaRepository<DialogMessage, Long> {
    DialogMessage findByid(Integer id);
}
