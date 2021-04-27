<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>
<@c.page>
        <@l.login "/registration" />
    <#if message??>
        ${message}
    </#if>
</@c.page>