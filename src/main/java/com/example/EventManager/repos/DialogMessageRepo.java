package com.example.EventManager.repos;

import com.example.EventManager.domain.DialogMessage;
import com.example.EventManager.domain.Message;
import org.springframework.data.repository.CrudRepository;

public interface DialogMessageRepo extends CrudRepository<DialogMessage, Long> {
}
