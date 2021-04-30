<#assign known = Session.SPRING_SECURITY_CONTEXT?? user2>
<#if known>
    <#assign
        user = Session.SPRING_SECURITY_CONTEXT.authentication.principal
        name = user.getUsername()
        currentUserId = user.getId()
        isAdmin = user.isAdmin()
        dialogId = user.getIdDialog(user, user2)>
    <#else>
    <#assign
        name = "unknown"
        isAdmin = false
        currentUserId = -1>
</#if>