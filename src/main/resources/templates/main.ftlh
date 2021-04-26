<!DOCTYPE HTML>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <title>Getting Started: Serving Web Content</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<body>
        <div>
                  <form method="POST">
                    <input type="text" name="header" placeholder="Enter header to you post">
                    <input type="text" name="theme" placeholder="Enter theme to you post">
                    <input type="text" name="text" placeholder="Enter text to you post">
                    <input type="text" name="date" placeholder="Enter date to you post">
                    <input type="text" name="author" placeholder="Enter header to you post">
                    <button type="submit">Add</button>
                  </form>
        </div>
    <div>
        <ul>
            <#list messages as message>
                    <li>${message.getId()} ${message.getHeader()} ${message.getTheme()} ${message.getText()} ${message.getDate()} ${message.getAuthor()}</li>
            </#list>
        </ul>
    </div>
</body>
</html>