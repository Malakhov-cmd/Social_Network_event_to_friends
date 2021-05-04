<#import "parts/common.ftlh" as c>
  <@c.page>
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
    <#if voteItems==true>
      <div class="form-group mb-3">
        <form method="POST" enctype="multipart/form-data">
          <div class="form-group">
            <div class="form-check">
              <input class="form-check-input" type="radio" name="voteChoose" id="exampleRadios1" value="Agree" checked>
              <label class="form-check-label" for="exampleRadios1">
                Of course!
              </label>
            </div>
          </div>
          <div class="form-group">
            <div class="form-check">
              <input class="form-check-input" type="radio" name="voteChoose" id="exampleRadios2" value="Against">
              <label class="form-check-label" for="exampleRadios2">
                Abstain
              </label>
            </div>
          </div>
          <div class="form-group">
            <div class="form-check">
              <input class="form-check-input" type="radio" name="voteChoose" id="exampleRadios3" value="Abstain">
              <label class="form-check-label" for="exampleRadios3">
                Can't participate
              </label>
            </div>
          </div>
          <div class="form-group">
            <button type="submit" class="btn btn-primary ml-2">Choose</button>
          </div>
          <input type="hidden" name="_csrf" value="${_csrf.token}" />
        </form>
      </div>
    </#if>
    <#if showDiagram?? && showDiagram==true>
      <form>
        <div class="form-group">
          <label for="input_text1">Ready to participate</label>
          <input type="text" class="form-control" name="input_text1" id="input_text1" max=${countUsers} readonly
            value=${usersVotedAgree?size} onchange="rangeinput1.value = input_text1.value" />
          <input type="range" oninput="input_text1.value = rangeinput1.value" class="form-control-range slider"
            type="range" min="0" max=${countUsers} value=${usersVotedAgree?size} id="rangeinput1" step="1"
            onchange="input_text1.value = rangeinput1.value" />
        </div>
        <div class="form-group">
          <label for="input_text2">Won't be with us</label>
          <input type="text" class="form-control" name="input_text2" id="input_text2" max=${countUsers} readonly
            value=${usersVotedAgainst?size} onchange="rangeinput2.value = input_text2.value" />
          <input type="range" oninput="input_text2.value = rangeinput2.value" class="form-control-range slider"
            type="range" min="0" max=${countUsers} value=${usersVotedAgainst?size} id="rangeinput2" step="1"
            onchange="input_text2.value = rangeinput2.value" />
        </div>
        <div class="form-group">
          <label for="input_text3">Unfortunately they won't be able to come</label>
          <input type="text" class="form-control" name="input_text3" id="input_text3" max=${countUsers} readonly
            value=${usersVotedAbstain?size} onchange="rangeinput3.value = input_text3.value" />
          <input type="range" oninput="input_text3.value = rangeinput3.value" class="form-control-range slider"
            type="range" min="0" max=${countUsers} value=${usersVotedAbstain?size} id="rangeinput3" step="1"
            onchange="input_text3.value = rangeinput3.value" />
        </div>
        <div class="form-group">
          <label for="input_text4">Did not vote</label>
          <input type="text" class="form-control" name="input_text4" id="input_text4" max=${countUsers} readonly
            value=${usersUnVoted} onchange="rangeinput4.value = input_text4.value" />
          <input type="range" oninput="input_text4.value = rangeinput4.value" class="form-control-range slider"
            type="range" min="0" max=${countUsers} value=${usersUnVoted} id="rangeinput4" step="1"
            onchange="input_text4.value = rangeinput4.value" />
        </div>
      </form>
    </#if>
  </@c.page>