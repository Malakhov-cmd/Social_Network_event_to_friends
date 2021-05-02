<#import "parts/common.ftlh" as c>
  <@c.page>
  <div class="container">
  <#if dialogSize==0>
    No messages yet
  <#else>
    <#list dialogMessList as dialogMes>
    <div class="row">
      <div class="col-sm">
        <#if dialogMes.getFrom()!=user>
          ${dialogMes.getText()}
        </#if>
      </div>
      <div class="col-sm">

      </div>
      <div class="col-sm">
        <#if dialogMes.getFrom()==user>
              ${dialogMes.getText()}
        </#if>
      </div>
      </div>
    </#list>
  </#if>
  </div>
    <form method="post">
      <div class="form-group">
        <label for="exampleFormControlTextarea1">Message</label>
        <textarea class="form-control" id="exampleFormControlTextarea1" rows="3" name="MessageText"></textarea>
      </div>
      <input type="hidden" name="_csrf" value="${_csrf.token}" />
      <div class="form-group">
        <button type="submit" class="btn btn-primary ml-2">Send</button>
      </div>
    </form>
  </@c.page>