package com.example.EventManager.repos;

import com.example.EventManager.domain.Message;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface MessageRepo extends CrudRepository<Message, Long> {
    List<Message> findByTheme(String theme);
    List<Message> findByText(String text);
    List<Message> findByAuthor(String author);
    List<Message> findByHeader(String header);
    Message findById(Integer id);
}
