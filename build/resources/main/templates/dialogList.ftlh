<#import "parts/common.ftlh" as c>
  <@c.page>
  <#if dialogSize!=0>
    <#list dialogs as dialog>
    <div class="card mb-3">
      <h5 class="card-header">${dialog.getSecondUser().getUsername()}</h5>
      <div class="card-body">
        <h5 class="card-title">@${dialog.getSecondUser().getId()}</h5>
        <#if dialog.getDialogMessageList()?size != 0>
          <#list dialog.getDialogMessageList() as message>
            <#if message_index == dialog.getDialogMessageList()?size-1>
              <p class="card-text">${message.getText()}</p>
            </#if>
          </#list>
        <#else>
          <p class="card-text">No messages yet</p>
        </#if>
        <a href="/dialog/${dialog.id}/${dialog.getFirstUser().getId()}/${dialog.getSecondUser().getId()}" class="btn btn-primary">Go to dialog</a>
      </div>
    </div>
    </#list>
  <#else>
    No dialogs yet
  </#if>
  </@c.page>