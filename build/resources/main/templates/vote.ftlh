<#import "parts/common.ftlh" as c>
  <@c.page>
    <script src="https://use.fontawesome.com/712d2bbdad.js"></script>
    <#if message.getActivityType()=="Sporty">
      <div class="card  text-white bg-success mb-3">
        <#if message.filename??>
          <img src="https://springeventmanager.s3.us-east-2.amazonaws.com/${message.filename}" class="card-img-top">
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
                <i>${message.getDate()}</i>
              </small>
            </p>
          </li>
          <li class="list-group-item bg-success">
            <div class="card-footer text-white">
              <strong>${message.getAuthorName()}</strong>
            </div>
          </li>
        </ul>
      </div>
    </#if>
    <#if message.getActivityType()=="Tourism">
      <div class="card bg-warning mb-3text-white">
        <#if message.filename??>
          <img src="https://springeventmanager.s3.us-east-2.amazonaws.com/${message.filename}" class="card-img-top">
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
                <i>${message.getDate()}</i>
              </small>
            </p>
          </li>
          <li class="list-group-item bg-warning">
            <div class="card-footer text-white">
              <strong>${message.getAuthorName()}</strong>
            </div>
          </li>
        </ul>
      </div>
    </#if>
    <#if message.getActivityType()=="Alcohol">
      <div class="card bg-danger text-white mb-3">
        <#if message.filename??>
          <img src="https://springeventmanager.s3.us-east-2.amazonaws.com/${message.filename}" class="card-img-top">
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
                <i>${message.getDate()}</i>
              </small>
            </p>
          </li>
          <li class="list-group-item bg-danger">
            <div class="card-footer text-white">
              <strong>${message.getAuthorName()}</strong>
            </div>
          </li>
        </ul>
      </div>
    </#if>
    <#if message.getActivityType()=="Conversation">
      <div class="card bg-primary text-white mb-3">
        <#if message.filename??>
          <img src="https://springeventmanager.s3.us-east-2.amazonaws.com/${message.filename}" class="card-img-top">
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
                <i>${message.getDate()}</i>
              </small>
            </p>
          </li>
          <li class="list-group-item bg-primary">
            <div class="card-footer text-white">
              <strong>${message.getAuthorName()}</strong>
            </div>
          </li>
        </ul>
      </div>
    </#if>
    <#if message.getActivityType()=="Game">
      <div class="card bg-info text-white mb-3">
        <#if message.filename??>
          <img src="https://springeventmanager.s3.us-east-2.amazonaws.com/${message.filename}" class="card-img-top">
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
                <i>${message.getDate()}</i>
              </small>
            </p>
          </li>
          <li class="list-group-item bg-info">
            <div class="card-footer text-white">
              <strong>${message.getAuthorName()}</strong>
            </div>
          </li>
        </ul>
      </div>
    </#if>
    <#if message.getActivityType()=="Movie">
      <div class="card bg-light mb-3">
        <#if message.filename??>
          <img src="https://springeventmanager.s3.us-east-2.amazonaws.com/${message.filename}" class="card-img-top">
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
              <small>
                <i>${message.getDate()}</i>
              </small>
            </p>
          </li>
          <li class="list-group-item bg-light">
            <div class="card-footer">
              <strong>${message.getAuthorName()}</strong>
            </div>
          </li>
        </ul>
      </div>
    </#if>
    <#if message.getActivityType()=="Club">
      <div class="card bg-danger text-white mb-3">
        <#if message.filename??>
          <img src="https://springeventmanager.s3.us-east-2.amazonaws.com/${message.filename}" class="card-img-top">
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
                <i>${message.getDate()}</i>
              </small>
            </p>
          </li>
          <li class="list-group-item bg-danger">
            <div class="card-footer text-white">
              <strong>${message.getAuthorName()}</strong>
            </div>
          </li>
        </ul>
      </div>
    </#if>
    <#if message.getActivityType()=="Bar">
      <div class="card bg-dark text-white mb-3">
        <#if message.filename??>
          <img src="https://springeventmanager.s3.us-east-2.amazonaws.com/${message.filename}" class="card-img-top">
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
                <i>${message.getDate()}</i>
              </small>
            </p>
          </li>
          <li class="list-group-item bg-dark">
            <div class="card-footer text-white">
              <strong>${message.getAuthorName()}</strong>
            </div>
          </li>
        </ul>
      </div>
    </#if>
    <#if message.getActivityType()=="Just walk">
      <div class="card bg-success text-white mb-3">
        <#if message.filename??>
          <img src="https://springeventmanager.s3.us-east-2.amazonaws.com/${message.filename}" class="card-img-top">
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
                <i>${message.getDate()}</i>
              </small>
            </p>
          </li>
          <li class="list-group-item bg-success">
            <div class="card-footer text-white">
              <strong>${message.getAuthorName()}</strong>
            </div>
          </li>
        </ul>
      </div>
    </#if>
    <div id="updateVote">
      <#if voteItems==true>
        <div class="form-group mb-3">
          <form method="POST" enctype="multipart/form-data" id="checkedVote" class="cls_checkedVote">
            <div class="form-group">
              <div class="form-check">
                <input class="voteExist form-check-input" type="radio" name="voteChoose" id="exampleRadios1"
                  value="Agree" checked>
                <label class="form-check-label" for="exampleRadios1">
                  Of course!
                </label>
              </div>
            </div>
            <div class="form-group">
              <div class="form-check">
                <input class="voteExist form-check-input" type="radio" name="voteChoose" id="exampleRadios2"
                  value="Against">
                <label class="form-check-label" for="exampleRadios2">
                  Abstain
                </label>
              </div>
            </div>
            <div class="form-group">
              <div class="form-check">
                <input class="voteExist form-check-input" type="radio" name="voteChoose" id="exampleRadios3"
                  value="Abstain">
                <label class="form-check-label" for="exampleRadios3">
                  Can't participate
                </label>
              </div>
            </div>
            <div class="form-group">
              <button type="submit" class="btn btn-primary ml-2">Choose</button>
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}" id="_csrfVoteId" />
          </form>
        </div>
      </#if>
      <#if showDiagram?? && showDiagram==true>
        <form>
          <div class="form-group">
            <label for="input_text1">Ready to participate</label>
            <input readonly type="text" class="form-control" name="input_text1" id="input_text1" max=${countUsers}
              readonly value=${usersVotedAgree?size} onchange="rangeinput1.value = input_text1.value" />
            <input readonly type="range" oninput="input_text1.value = rangeinput1.value"
              class="form-control-range slider" type="range" min="0" max=${countUsers} value=${usersVotedAgree?size}
              id="rangeinput1" step="1" onchange="input_text1.value = rangeinput1.value" />
          </div>
          <div class="form-group">
            <label for="input_text2">Won't be with us</label>
            <input readonly type="text" class="form-control" name="input_text2" id="input_text2" max=${countUsers}
              readonly value=${usersVotedAgainst?size} onchange="rangeinput2.value = input_text2.value" />
            <input readonly type="range" oninput="input_text2.value = rangeinput2.value"
              class="form-control-range slider" type="range" min="0" max=${countUsers} value=${usersVotedAgainst?size}
              id="rangeinput2" step="1" onchange="input_text2.value = rangeinput2.value" />
          </div>
          <div class="form-group">
            <label for="input_text3">Unfortunately they won't be able to come</label>
            <input readonly type="text" class="form-control" name="input_text3" id="input_text3" max=${countUsers}
              readonly value=${usersVotedAbstain?size} onchange="rangeinput3.value = input_text3.value" />
            <input readonly type="range" oninput="input_text3.value = rangeinput3.value"
              class="form-control-range slider" type="range" min="0" max=${countUsers} value=${usersVotedAbstain?size}
              id="rangeinput3" step="1" onchange="input_text3.value = rangeinput3.value" />
          </div>
          <div class="form-group">
            <label for="input_text4">Did not vote</label>
            <input readonly type="text" class="form-control" name="input_text4" id="input_text4" max=${countUsers}
              readonly value=${usersUnVoted} onchange="rangeinput4.value = input_text4.value" />
            <input readonly type="range" oninput="input_text4.value = rangeinput4.value"
              class="form-control-range slider" type="range" min="0" max=${countUsers} value=${usersUnVoted}
              id="rangeinput4" step="1" onchange="input_text4.value = rangeinput4.value" />
          </div>
          <style>
            .form-control-range {
              pointer-events: none;
            }
          </style>
        </form>
        <button type="button" class="btn btn-primary mb-3"
          onclick="window.location.href='/vote/discussion/${message.id}/${voteMessageDialog.id}/${user.id}'; return false"><i
            class="fa fa-comments" aria-hidden="true"></i> Discuss</button>
      </#if>
    </div>
    <script type='text/javascript'>
      var xmlDocument;
      var formVoteCheck = document.querySelector('.cls_checkedVote');

      if (formVoteCheck != null) {
        formVoteCheck.onsubmit = function refresh(event) {
          const inputs = document.querySelectorAll('.voteExist');

          var container;

          inputs.forEach(el => {
            let input_checkeds = document.querySelector('input:checked');
            container = input_checkeds.value;
          });
          console.log(container);

          var data = {
            voteChoose: container,
          };

          var boundary = String(Math.random()).slice(1);
          var boundaryMiddle = '--' + boundary + '\r\n';
          var boundaryLast = '--' + boundary + '--\r\n';

          var body = ['\r\n'];
          for (var key in data) {
            body.push('Content-Disposition: form-data; name="' + key + '"\r\n\r\n' + data[key] + '\r\n');
          }

          body = body.join(boundaryMiddle) + boundaryLast;

          event.preventDefault();
          var XMLHttpRequestObject = false;
          if (window.XMLHttpRequest)
            XMLHttpRequestObject = new XMLHttpRequest();
          else if (window.ActiveXobject)
            XMLHttpRequestObject = new ActiveXObject("Microsoft.XMLHTTP");

          if (XMLHttpRequestObject) {
            XMLHttpRequestObject.open('POST', "/vote/${message.getId()}/${user.getId()}", true);
            XMLHttpRequestObject.setRequestHeader('X-CSRF-Token', document.getElementById('_csrfVoteId').value);
            XMLHttpRequestObject.setRequestHeader('Content-Type', 'multipart/form-data; boundary=' + boundary);
            XMLHttpRequestObject.responseType = 'document';
            XMLHttpRequestObject.onreadystatechange = function () {
              if (XMLHttpRequestObject.readyState == 4 && XMLHttpRequestObject.status == 200) {
                xmlDocument = XMLHttpRequestObject.responseXML;
                document.getElementById('updateVote').innerHTML = xmlDocument.getElementById('updateVote').innerHTML;
                console.log("Update vote");
              }
            }
            XMLHttpRequestObject.send(body);
          }
        };
      }
    </script>
  </@c.page>