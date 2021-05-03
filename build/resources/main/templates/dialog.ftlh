<#import "parts/common.ftlh" as c>
  <@c.page>
  <div id="Chat_Mess">
    <div class="container">
      <#if dialogSize==0>
        No messages yet
        <#else>
          <#list dialogMessList as dialogMes>
            <div class="row">
              <div class="col-sm">
                <#if dialogMes.getFromId()==target>
                  <div class="shadow p-3 mb-5 bg-white rounded">
                    <p class="lead">
                      ${dialogMes.getText()}
                    </p>
                    <small class="form-text text-muted">${dialogMes.getDate()}</small>
                  </div>
                </#if>
              </div>
              <div class="col-sm">

              </div>
              <div class="col-sm">
                <#if dialogMes.getFromId()==user>
                  <div class="shadow p-3 mb-5 bg-white rounded">
                    <p class="lead">
                      ${dialogMes.getText()}
                    </p>
                    <small class="form-text text-muted">${dialogMes.getDate()}</small>
                  </div>
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
    <script type="text/javascript">
      window.scrollTo(0, document.body.scrollHeight);
    </script>
  </div>
  </@c.page>