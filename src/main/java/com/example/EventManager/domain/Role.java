package com.example.EventManager.domain;

import org.springframework.security.core.GrantedAuthority;

public enum Role implements GrantedAuthority {
    USER, ADMIN;

    //возвращает привязанную роль
    @Override
    public String getAuthority() {
        return name();
    }
}

