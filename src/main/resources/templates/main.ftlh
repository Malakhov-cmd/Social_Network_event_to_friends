<!DOCTYPE HTML>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <title>Getting Started: Serving Web Content</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<body>
<form action="/logout" method="post">
            <input type="submit" value="Sign Out"/>
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        </form>
        <div>
                  <form method="POST">
                    <input type="text" name="header" placeholder="Enter header to you post">
                    <input type="text" name="theme" placeholder="Enter theme to you post">
                    <input type="text" name="text" placeholder="Enter text to you post">
                    <input type="text" name="date" placeholder="Enter date to you post">
                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                    <button type="submit">Add</button>
                  </form>
        </div>
                <div>
                  <form method="POST" action="filter">
                    <input type="text" name="filter">
                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                    <button type="submit">find</button>
                  </form>
                </div>
    <div>
        <ul>
            <#list messages as message>
                    <li>${message.getId()} ${message.getHeader()} ${message.getTheme()} ${message.getText()} ${message.getDate()} <strong>${message.getAuthorName()}</strong></li>
            </#list>
        </ul>
    </div>
</body>
</html>