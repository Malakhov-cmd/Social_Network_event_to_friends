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