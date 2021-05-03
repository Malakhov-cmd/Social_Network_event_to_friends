package com.example.EventManager.repos;

import com.example.EventManager.domain.Dialog;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DialogRepo extends JpaRepository<Dialog, Long> {
    Dialog findByid(Integer id);
}
