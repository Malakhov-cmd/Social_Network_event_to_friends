<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>
<@c.page>
        <div>
        <@l.logout />
        <span><a href="/user">User list</a></span>
        </div>
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
                  <form method="get" action="/main">
                    <input type="text" name="filter" value="${filter}">
                    <button type="submit">find</button>
                  </form>
                </div>
    <div>
        <ul>
            <#list messages as message>
                    <li>${message.getId()} ${message.getHeader()} ${message.getTheme()} ${message.getText()} ${message.getDate()} <strong>${message.getAuthorName()}</strong></li>
                    <#else>
                    No messages yet
            </#list>
        </ul>
    </div>
</@c.page>