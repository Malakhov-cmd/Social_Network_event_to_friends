<#include "security.ftlh">
<#import "login.ftlh" as l>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="#">Event Manager</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item">
        <a class="nav-link" href="/">Home</a>
      </li>
      <#if user??>
      <li class="nav-item">
        <a class="nav-link" href="/profile/${currentUserId}">My profile</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/twitboard/${currentUserId}">Board</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/dialogs/${currentUserId}">Dialogs</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/rooms/${currentUserId}">Rooms</a>
      </li>
      </#if>
      <#if isAdmin>
      <li class="nav-item">
        <a class="nav-link" href="/user">User list</a>
      </li>
      </#if>
    </ul>
    <div class="navbar-text">${name}</div>
    <#if currentUserId==-1>
      <button type="submit" class="btn btn-primary ml-2">
      <a href="/login" target="_parent" style="color: white; text-decoration: none;">
        Sign in
      </a>
      </button>
      <input type="hidden" name="_csrf" value="${_csrf.token}"/>
    <#else>
      <@l.logout />
    </#if>
  </div>
</nav>
