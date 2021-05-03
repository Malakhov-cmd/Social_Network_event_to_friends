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
    <div class="collapse" id="collapseExample">
      <div class="form-group mb-3">
        <form method="POST" enctype="multipart/form-data">
          <div class="form-group mt-4">
            <input type="text" class="form-control" name="header" placeholder="Enter header to you post">
          </div>
          <div class="form-group">
            <input type="text" class="form-control" name="theme" placeholder="Enter theme to you post">
          </div>

          <div class="form-group">
            <select class="custom-select" name="activityType">
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
          </div>

          <div class="form-group">
            <input type="text" class="form-control" name="text" placeholder="Enter text to you post">
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
            <div class="card bg-success mb-3">
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
                </li>
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
            </div>
          </#if>
          <#if message.getActivityType()=="Tourism">
            <div class="card bg-warning mb-3">
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
                </li>
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
            </div>
          </#if>
          <#if message.getActivityType()=="Alcohol">
            <div class="card bg-danger mb-3">
              <#if message.filename??>
                <img src="/img/${message.filename}" class="card-img-top">
              </#if>
              <ul class="list-group bg-danger list-group-flush">
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
                    <small class="text-muted">
                      <i>${message.getDate()}</i>
                    </small>
                  </p>
                </li>
                <li class="list-group-item bg-danger">
                  <div class="card-footer text-muted">
                    <strong>${message.getAuthorName()}</strong>
                  </div>
                </li>
              </ul>
            </div>
          </#if>
          <#if message.getActivityType()=="Conversation">
            <div class="card bg-primary mb-3">
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
                </li>
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
            </div>
          </#if>
          <#if message.getActivityType()=="Game">
            <div class="card bg-info mb-3">
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
                </li>
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
            </div>
          </#if>
          <#if message.getActivityType()=="Movie">
            <div class="card bg-light mb-3">
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
                </li>
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
            </div>
          </#if>
          <#if message.getActivityType()=="Club">
            <div class="card bg-danger mb-3">
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
                </li>
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
            </div>
          </#if>
          <#if message.getActivityType()=="Bar">
            <div class="card bg-dark mb-3">
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
                </li>
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
            </div>
          </#if>
          <#if message.getActivityType()=="Just walk">
            <div class="card bg-success mb-3">
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
                </li>
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
            </div>
          </#if>
        </#list>
      </div>
    </div>
  </@c.page>