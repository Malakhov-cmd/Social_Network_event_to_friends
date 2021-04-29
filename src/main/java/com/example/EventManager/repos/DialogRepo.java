package com.example.EventManager.repos;

import com.example.EventManager.domain.Dialog;
import com.example.EventManager.domain.Message;
import org.springframework.data.repository.CrudRepository;

public interface DialogRepo extends CrudRepository<Dialog, Long> {
}
