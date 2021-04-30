package com.example.EventManager.repos;

import com.example.EventManager.domain.Dialog;
import com.example.EventManager.domain.Message;
import com.example.EventManager.domain.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;

public interface DialogRepo extends JpaRepository<Dialog, Long> {
    Dialog findByid(Integer id);
}
