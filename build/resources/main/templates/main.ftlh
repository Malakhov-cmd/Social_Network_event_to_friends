<#import "parts/common.ftlh" as c>
  <@c.page>
    <div class="form-row">
      <div class="form-group col-md-6">
        <form method="get" action="/main" class="form-inline">
          <input type="text" name="filter" value="${filter?ifExists}" class="form-control" placeholder="Search">
          <button type="submit" class="btn btn-primary ml-2">find</button>
        </form>
      </div>
    </div>
    <a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false"
      aria-controls="collapseExample">
      Add new message
    </a>
    <div class="collapse <#if message??>show</#if>" id="collapseExample">
      <div class="form-group mb-3">
        <form method="POST" enctype="multipart/form-data">
          <div class="form-group mt-4">
            <input type="text" class="form-control  ${(headerError??)?string('is-invalid', '')}" name="header" placeholder="Enter header to you post"  value="<#if message??>${message.header}</#if>">
            <#if headerError??>
              <div class="invalid-feedback">
                ${headerError}
              </div>
            </#if>
          </div>
          <div class="form-group">
            <input type="text" class="form-control  ${(themeError??)?string('is-invalid', '')}" name="theme" placeholder="Enter theme to you post" value="<#if message??>${message.theme}</#if>">
            <#if themeError??>
              <div class="invalid-feedback">
                ${themeError}
              </div>
            </#if>
          </div>

          <div class="form-group ">
            <select class="custom-select ${(activityTypeError??)?string('is-invalid', '')}" name="activityType" value="<#if message??>${message.activityType}</#if>">
              <option selected>Choose your type activity</option>
              <option value="Sporty">Sporty</option>
              <option value="Tourism">Tourism</option>
              <option value="Alcohol">Alcohol</option>
              <option value="Conversation">Conversation</option>
              <option value="Game">Game</option>
              <option value="Movie">Movie</option>
              <option value="Club">Club</option>
              <option value="Bar">Bar</option>
              <option value="Just walk">Just walk</option>
            </select>
            <#if activityTypeError??>
              <div class="invalid-feedback">
                ${activityTypeError}
              </div>
            </#if>
          </div>

          <div class="form-group">
            <input type="text" class="form-control ${(textError??)?string('is-invalid', '')}" name="text" placeholder="Enter text to you post" value="<#if message??>${message.text}</#if>">
            <#if textError??>
              <div class="invalid-feedback">
                ${textError}
              </div>
            </#if>
          </div>
          <div class="form-group">
            <div class="custom-file">
              <input type="file" id="customFile" name="file">
              <label class="custom-file-label" for="customFile">Choose file</label>
            </div>
          </div>
          <input type="hidden" name="_csrf" value="${_csrf.token}" />
          <div class="form-group">
            <button type="submit" class="btn btn-primary ml-2">Add</button>
          </div>
        </form>
      </div>
    </div>
    <div>
      <div class="card-columns m-3">
        <#list messages as message>
          <#if message.getActivityType()=="Sporty">
            <div class="card text-white bg-success mb-3">
              <#if message.filename??>
                <img src="/img/${message.filename}" class="card-img-top">
              </#if>
              <ul class="list-group list-group-flush bg-success">
                <li class="list-group-item bg-success">
                  <h5 class="card-title">${message.getHeader()}</h5>
                </li>
                <li class="list-group-item bg-success">
                  <h5 class="card-title"></h5>${message.getTheme()}</h5>
                </li>
                <li class="list-group-item bg-success">
                  <div class="card-text m-2">
                    <span>${message.getText()}</span>
                  </div>
                </li>
                <li class="list-group-item bg-success">
                  <p class="card-text">
                    <small class="text-white">
                      <i><em>${message.getDate()}</em></i>
                    </small>
                  </p>
                </li>
                <li class="list-group-item bg-success">
                  <div class="card-footer text-white">
                    <strong><em>${message.getAuthorName()}</em></strong>
                  </div>
                </li>
              </ul>
              <button type="button" class="btn btn-primary mt-3 mb-2 ml-2"
                onclick="window.location.href='/vote/${message.id}/${user.id}'; return false">Vote</button>
            </div>
          </#if>
          <#if message.getActivityType()=="Tourism">
            <div class="card text-white bg-warning mb-3">
              <#if message.filename??>
                <img src="/img/${message.filename}" class="card-img-top">
              </#if>
              <ul class="list-group list-group-flush bg-warning">
                <li class="list-group-item bg-warning">
                  <h5 class="card-title">${message.getHeader()}</h5>
                </li>
                <li class="list-group-item bg-warning">
                  <h5 class="card-title"></h5>${message.getTheme()}</h5>
                </li>
                <li class="list-group-item bg-warning">
                  <div class="card-text m-2">
                    <span>${message.getText()}</span>
                  </div>
                </li>
                <li class="list-group-item bg-warning">
                  <p class="card-text">
                    <small class="text-white">
                      <i><em>${message.getDate()}</em>></i>
                    </small>
                  </p>
                </li>
                <li class="list-group-item bg-warning">
                  <div class="card-footer text-white">
                    <strong><em>${message.getAuthorName()}</em>></strong>
                  </div>
                </li>
              </ul>
              <button type="button" class="btn btn-primary mt-3 mb-2 ml-2"
                onclick="window.location.href='/vote/${message.id}/${user.id}'; return false">Vote</button>
            </div>
      </div>
      </#if>
      <#if message.getActivityType()=="Alcohol">
        <div class="card text-white bg-danger mb-3">
          <#if message.filename??>
            <img src="/img/${message.filename}" class="card-img-top">
          </#if>
          <ul class="list-group list-group-flush bg-danger">
            <li class="list-group-item bg-danger">
              <h5 class="card-title">${message.getHeader()}</h5>
            </li>
            <li class="list-group-item bg-danger">
              <h5 class="card-title"></h5>${message.getTheme()}</h5>
            </li>
            <li class="list-group-item bg-danger">
              <div class="card-text m-2">
                <span>${message.getText()}</span>
              </div>
            </li>
            <li class="list-group-item bg-danger">
              <p class="card-text">
                <small class="text-white">
                  <i><em>${message.getDate()}</em></i>
                </small>
              </p>
            </li>
            <li class="list-group-item bg-danger">
              <div class="card-footer text-white">
                <strong><em>${message.getAuthorName()}</em></strong>
              </div>
            </li>
          </ul>
          <button type="button" class="btn btn-primary mt-3 mb-2 ml-2"
            onclick="window.location.href='/vote/${message.id}/${user.id}'; return false">Vote</button>
        </div>
    </div>
    </#if>
    <#if message.getActivityType()=="Conversation">
      <div class="card text-white bg-primary mb-3">
        <#if message.filename??>
          <img src="/img/${message.filename}" class="card-img-top">
        </#if>
        <ul class="list-group list-group-flush bg-primary">
          <li class="list-group-item bg-primary">
            <h5 class="card-title">${message.getHeader()}</h5>
          </li>
          <li class="list-group-item bg-primary">
            <h5 class="card-title"></h5>${message.getTheme()}</h5>
          </li>
          <li class="list-group-item bg-primary">
            <div class="card-text m-2">
              <span>${message.getText()}</span>
            </div>
          </li>
          <li class="list-group-item bg-primary">
            <p class="card-text">
              <small class="text-white">
                <i><em>${message.getDate()}</em></i>
              </small>
            </p>
          </li>
          <li class="list-group-item bg-primary">
            <div class="card-footer text-white">
              <strong><em>${message.getAuthorName()}</em></strong>
            </div>
          </li>
        </ul>
        <button type="button" class="btn btn-primary mt-3 mb-2 ml-2"
          onclick="window.location.href='/vote/${message.id}/${user.id}'; return false">Vote</button>
      </div>
      </div>
    </#if>
    <#if message.getActivityType()=="Game">
      <div class="card text-white bg-info mb-3">
        <#if message.filename??>
          <img src="/img/${message.filename}" class="card-img-top">
        </#if>
        <ul class="list-group list-group-flush bg-info">
          <li class="list-group-item bg-info">
            <h5 class="card-title">${message.getHeader()}</h5>
          </li>
          <li class="list-group-item bg-info">
            <h5 class="card-title"></h5>${message.getTheme()}</h5>
          </li>
          <li class="list-group-item bg-info">
            <div class="card-text m-2">
              <span>${message.getText()}</span>
            </div>
          </li>
          <li class="list-group-item bg-info">
            <p class="card-text">
              <small class="text-white">
                <i><em>${message.getDate()}</em></i>
              </small>
            </p>
          </li>
          <li class="list-group-item bg-info">
            <div class="card-footer text-white">
              <strong><em>${message.getAuthorName()}</em></strong>
            </div>
          </li>
        </ul>
        <button type="button" class="btn btn-primary mt-3 mb-2 ml-2"
          onclick="window.location.href='/vote/${message.id}/${user.id}'; return false">Vote</button>
      </div>
      </div>
    </#if>
    <#if message.getActivityType()=="Movie">
      <div class="card text-white bg-light mb-3">
        <#if message.filename??>
          <img src="/img/${message.filename}" class="card-img-top">
        </#if>
        <ul class="list-group list-group-flush bg-light">
          <li class="list-group-item bg-light">
            <h5 class="card-title">${message.getHeader()}</h5>
          </li>
          <li class="list-group-item bg-light">
            <h5 class="card-title"></h5>${message.getTheme()}</h5>
          </li>
          <li class="list-group-item bg-light">
            <div class="card-text m-2">
              <span>${message.getText()}</span>
            </div>
          </li>
          <li class="list-group-item bg-light">
            <p class="card-text">
              <small class="text-white">
                <i><em>${message.getDate()}</em></i>
              </small>
            </p>
          </li>
          <li class="list-group-item bg-light">
            <div class="card-footer text-white">
              <strong><em>${message.getAuthorName()}</em></strong>
            </div>
          </li>
        </ul>
        <button type="button" class="btn btn-primary mt-3 mb-2 ml-2"
          onclick="window.location.href='/vote/${message.id}/${user.id}'; return false">Vote</button>
      </div>
      </div>
    </#if>
    <#if message.getActivityType()=="Club">
      <div class="card text-white bg-danger mb-3">
        <#if message.filename??>
          <img src="/img/${message.filename}" class="card-img-top">
        </#if>
        <ul class="list-group list-group-flush bg-danger">
          <li class="list-group-item bg-danger">
            <h5 class="card-title">${message.getHeader()}</h5>
          </li>
          <li class="list-group-item bg-danger">
            <h5 class="card-title"></h5>${message.getTheme()}</h5>
          </li>
          <li class="list-group-item bg-danger">
            <div class="card-text m-2">
              <span>${message.getText()}</span>
            </div>
          </li>
          <li class="list-group-item bg-danger">
            <p class="card-text">
              <small class="text-white">
                <i><em>${message.getDate()}</em></i>
              </small>
            </p>
          </li>
          <li class="list-group-item bg-danger">
            <div class="card-footer text-white">
              <strong><em>${message.getAuthorName()}</em></strong>
            </div>
          </li>
        </ul>
        <button type="button" class="btn btn-primary mt-3 mb-2 ml-2"
          onclick="window.location.href='/vote/${message.id}/${user.id}'; return false">Vote</button>
      </div>
      </div>
    </#if>
    <#if message.getActivityType()=="Bar">
      <div class="card text-white bg-dark mb-3">
        <#if message.filename??>
          <img src="/img/${message.filename}" class="card-img-top">
        </#if>
        <ul class="list-group list-group-flush bg-dark">
          <li class="list-group-item bg-dark">
            <h5 class="card-title">${message.getHeader()}</h5>
          </li>
          <li class="list-group-item bg-dark">
            <h5 class="card-title"></h5>${message.getTheme()}</h5>
          </li>
          <li class="list-group-item bg-dark">
            <div class="card-text m-2">
              <span>${message.getText()}</span>
            </div>
          </li>
          <li class="list-group-item bg-dark">
            <p class="card-text">
              <small class="text-white">
                <i><em>${message.getDate()}</em></i>
              </small>
            </p>
          </li>
          <li class="list-group-item bg-dark">
            <div class="card-footer text-white">
              <strong><em>${message.getAuthorName()}</em></strong>
            </div>
          </li>
        </ul>
        <button type="button" class="btn btn-primary mt-3 mb-2 ml-2"
          onclick="window.location.href='/vote/${message.id}/${user.id}'; return false">Vote</button>
      </div>
      </div>
    </#if>
    <#if message.getActivityType()=="Just walk">
      <div class="card text-white bg-success mb-3">
        <#if message.filename??>
          <img src="/img/${message.filename}" class="card-img-top">
        </#if>
        <ul class="list-group list-group-flush bg-success">
          <li class="list-group-item bg-success">
            <h5 class="card-title">${message.getHeader()}</h5>
          </li>
          <li class="list-group-item bg-success">
            <h5 class="card-title"></h5>${message.getTheme()}</h5>
          </li>
          <li class="list-group-item bg-success">
            <div class="card-text m-2">
              <span>${message.getText()}</span>
            </div>
          </li>
          <li class="list-group-item bg-success">
            <p class="card-text">
              <small class="text-white">
                <i><em>${message.getDate()}</em></i>
              </small>
            </p>
          </li>
          <li class="list-group-item bg-success">
            <div class="card-footer text-white">
              <strong><em>${message.getAuthorName()}</em></strong>
            </div>
          </li>
        </ul>
        <button type="button" class="btn btn-primary mt-3 mb-2 ml-2"
          onclick="window.location.href='/vote/${message.id}/${user.id}'; return false">Vote</button>
      </div>
      </div>
    </#if>
    </#list>
    </div>
    </div>
  </@c.page>