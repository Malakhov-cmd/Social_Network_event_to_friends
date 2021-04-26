package com.example.EventManager.repos;

import com.example.EventManager.domain.Message;
import org.springframework.data.repository.CrudRepository;

public interface MessageRepo extends CrudRepository<Message, Long> {
}
