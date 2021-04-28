<#macro card message>
                    <#if message.filename??>
                      <img src="/img/${message.filename}" class="card-img-top">
                    </#if>
                    <ul class="list-group list-group-flush">
                      <li class="list-group-item">
                        <h5 class="card-title">${message.getHeader()}</h5>
                      </li>
                      <li class="list-group-item">
                        <h5 class="card-title"></h5>${message.getTheme()}</h5>
                      </li>
                      <li class="list-group-item">
                        <div class="card-text m-2">
                          <span>${message.getText()}</span>
                        </div>
                      <li class="list-group-item">
                        <p class="card-text">
                          <small class="text-muted">
                            <i>${message.getDate()}</i>
                          </small>
                        </p>
                      </li>
                      <li class="list-group-item">
                        <div class="card-footer text-muted">
                          <strong>${message.getAuthorName()}</strong>
                        </div>
                      </li>
                    </ul>
</#macro>