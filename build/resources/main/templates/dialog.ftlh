<div id="Chat_Mess">
<#import "parts/common.ftlh" as c>
  <@c.page>

      <div class="container">
        <div id="update_pls">
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
            <button type="submit" class="btn btn-primary ml-2" id="try_empty">Send</button>
          </div>
        </form>

      </div>
      </div>
      <script type="text/javascript">
        window.scrollTo(0, document.body.scrollHeight);
      </script>

      <script type='text/javascript'>
        document.getElementById("exampleFormControlTextarea1").focus();

        const inputValue = document.getElementById('exampleFormControlTextarea1');
        const enterEmpty = document.getElementById('try_empty');

        inputValue.addEventListener("focusout", () => {
            if(!document.querySelector('textarea:focus')) {
            setTimeout(function() {
                enterEmpty.click();
                }, 1000 );
            }
        });
      </script>

  </@c.page>
