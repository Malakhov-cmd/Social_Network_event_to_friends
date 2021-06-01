<#import "parts/common.ftlh" as c>
  <@c.page>
    <script src="https://use.fontawesome.com/712d2bbdad.js"></script>
    <div class="form-row">
      <div class="form-group col-md-6">
        <label class="label" for="filterLabel">Filter via Header of message</label>
        <form method="get" class="cls_filter form-inline" id="filterLabel">
          <input type="text" name="filter" value="${filter?ifExists}" class="cls_filterTxt form-control"
            placeholder="Search">
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
        <form method="POST" enctype="multipart/form-data" id="AddMessageForm">
          <div class="form-group mt-4">
            <input type="text" class="form-control  ${(headerError??)?string('is-invalid', '')}" name="header"
              placeholder="Enter header to you post" value="<#if message??>${message.header}</#if>"
              id="MesHeaderCreation">
            <#if headerError??>
              <div class="invalid-feedback">
                ${headerError}
              </div>
            </#if>
          </div>
          <div class="form-group">
            <input type="text" class="form-control  ${(themeError??)?string('is-invalid', '')}" name="theme"
              placeholder="Enter theme to you post" value="<#if message??>${message.theme}</#if>" id="MesThemeCreation">
            <#if themeError??>
              <div class="invalid-feedback">
                ${themeError}
              </div>
            </#if>
          </div>

          <div class="form-group ">
            <select class="custom-select ${(activityTypeError??)?string('is-invalid', '')}" name="activityType"
              value="<#if message??>${message.activityType}</#if>" id="selectMesCreation">
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
            <input type="text" class="form-control ${(textError??)?string('is-invalid', '')}" name="text"
              placeholder="Enter text to you post" value="<#if message??>${message.text}</#if>" id="MesTextCreation">
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

          <#if FormatException??>
            <label class="col-sm-2 col-form-label">${FormatException}</label>
          </#if>

          <input type="hidden" name="_csrf" value="${_csrf.token}" id="_csrfMesCreation" />
          <div class="form-group">
            <button type="submit" class="btn btn-primary ml-2">Add</button>
          </div>
        </form>
      </div>
    </div>
    <div id="updateRoomName">
      <div class="row mt-3 mb-2">
        <#list messages as message>
          <#if message.getActivityType()=="Sporty">
            <div class="col-md-6 col-xl-3">
              <div class="card mx-auto mb-4 text-white bg-success" style="max-width: 300px;">
                <#if message.filename??>
                  <img src="https://springeventmanager.s3.us-east-2.amazonaws.com/${message.filename}"
                    class="card-img-top">
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
                  onclick="window.location.href='/vote/${message.id}/${user.id}'; return false"
                  style="max-width: 92%;"><i class="fa fa-users" aria-hidden="true"></i> Vote</button>
              </div>
            </div>
          </#if>
          <#if message.getActivityType()=="Tourism">
            <div class="col-md-6 col-xl-3">
              <div class="card mx-auto mb-4 text-white bg-warning" style="max-width: 300px;">
                <#if message.filename??>
                  <img src="https://springeventmanager.s3.us-east-2.amazonaws.com/${message.filename}"
                    class="card-img-top">
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
                  onclick="window.location.href='/vote/${message.id}/${user.id}'; return false"><i class="fa fa-users"
                    aria-hidden="true"></i> Vote</button>
              </div>
            </div>
          </#if>
          <#if message.getActivityType()=="Alcohol">
            <div class="col-md-6 col-xl-3">
              <div class="card mx-auto mb-4 text-white bg-danger" style="max-width: 300px;">
                <#if message.filename??>
                  <img src="https://springeventmanager.s3.us-east-2.amazonaws.com/${message.filename}"
                    class="card-img-top">
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
                  onclick="window.location.href='/vote/${message.id}/${user.id}'; return false"><i class="fa fa-users"
                    aria-hidden="true"></i> Vote</button>
              </div>
            </div>
          </#if>
          <#if message.getActivityType()=="Conversation">
            <div class="col-md-6 col-xl-3">
              <div class="card mx-auto mb-4 text-white bg-primary" style="max-width: 300px;">
                <#if message.filename??>
                  <img src="https://springeventmanager.s3.us-east-2.amazonaws.com/${message.filename}"
                    class="card-img-top">
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
                  onclick="window.location.href='/vote/${message.id}/${user.id}'; return false"><i class="fa fa-users"
                    aria-hidden="true"></i> Vote</button>
              </div>
            </div>
          </#if>
          <#if message.getActivityType()=="Game">
            <div class="col-md-6 col-xl-3">
              <div class="card mx-auto mb-4 text-white bg-info" style="max-width: 300px;">
                <#if message.filename??>
                  <img src="https://springeventmanager.s3.us-east-2.amazonaws.com/${message.filename}"
                    class="card-img-top">
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
                  onclick="window.location.href='/vote/${message.id}/${user.id}'; return false"><i class="fa fa-users"
                    aria-hidden="true"></i> Vote</button>
              </div>
            </div>
          </#if>
          <#if message.getActivityType()=="Movie">
            <div class="col-md-6 col-xl-3">
              <div class="card mx-auto mb-4 bg-light" style="max-width: 300px;">
                <#if message.filename??>
                  <img src="https://springeventmanager.s3.us-east-2.amazonaws.com/${message.filename}"
                    class="card-img-top">
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
                        <i><em>${message.getDate()}</em></i>
                      </small>
                    </p>
                  </li>
                  <li class="list-group-item bg-light">
                    <div class="card-footer">
                      <strong><em>${message.getAuthorName()}</em></strong>
                    </div>
                  </li>
                </ul>
                <button type="button" class="btn btn-primary mt-3 mb-2 ml-2"
                  onclick="window.location.href='/vote/${message.id}/${user.id}'; return false"><i class="fa fa-users"
                    aria-hidden="true"></i> Vote</button>
              </div>
            </div>
          </#if>
          <#if message.getActivityType()=="Club">
            <div class="col-md-6 col-xl-3">
              <div class="card mx-auto mb-4 text-white bg-danger" style="max-width: 300px;">
                <#if message.filename??>
                  <img src="https://springeventmanager.s3.us-east-2.amazonaws.com/${message.filename}"
                    class="card-img-top">
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
                  onclick="window.location.href='/vote/${message.id}/${user.id}'; return false"><i class="fa fa-users"
                    aria-hidden="true"></i> Vote</button>
              </div>
            </div>
          </#if>
          <#if message.getActivityType()=="Bar">
            <div class="col-md-6 col-xl-3">
              <div class="card mx-auto mb-4 text-white bg-dark" style="max-width: 300px;">
                <#if message.filename??>
                  <img src="https://springeventmanager.s3.us-east-2.amazonaws.com/${message.filename}"
                    class="card-img-top">
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
                  onclick="window.location.href='/vote/${message.id}/${user.id}'; return false"><i class="fa fa-users"
                    aria-hidden="true"></i> Vote</button>
              </div>
            </div>
          </#if>
          <#if message.getActivityType()=="Just walk">
            <div class="col-md-6 col-xl-3">
              <div class="card mx-auto mb-4 text-white bg-success" style="max-width: 300px;">
                <#if message.filename??>
                  <img src="https://springeventmanager.s3.us-east-2.amazonaws.com/${message.filename}"
                    class="card-img-top">
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
                  onclick="window.location.href='/vote/${message.id}/${user.id}'; return false"><i class="fa fa-users"
                    aria-hidden="true"></i> Vote</button>
              </div>
            </div>
          </#if>
        </#list>
      </div>
    </div>
    <script type='text/javascript'>
      var xmlDocument;

      setInterval(function refresh() {
        var formFilter = document.querySelector('.cls_filter');

        var filterInput = document.querySelector('.cls_filterTxt');
        var valfilterInput = filterInput.value;

        if (filterInput.value != "") {
          console.log(filterInput.value);
          formFilter.onsubmit = function refresh(event) {
            event.preventDefault();
            var XMLHttpRequestObject = false;
            if (window.XMLHttpRequest)
              XMLHttpRequestObject = new XMLHttpRequest();
            else if (window.ActiveXobject)
              XMLHttpRequestObject = new ActiveXObject("Microsoft.XMLHTTP");

            if (XMLHttpRequestObject) {
              XMLHttpRequestObject.open('GET', "/room/${room.getRoomName()}/${room.getId()}/${user.getId()}/?filter=" + valfilterInput, true);
              XMLHttpRequestObject.responseType = 'document';
              XMLHttpRequestObject.onreadystatechange = function () {
                if (XMLHttpRequestObject.readyState == 4 && XMLHttpRequestObject.status == 200) {
                  xmlDocument = XMLHttpRequestObject.responseXML;
                  document.getElementById('updateRoomName').innerHTML = xmlDocument.getElementById('updateRoomName').innerHTML;
                  console.log("Update list message filter");
                }
              }
              XMLHttpRequestObject.send();
            }
          };
        } else {

          var XMLHttpRequestObject = false;
          if (window.XMLHttpRequest)
            XMLHttpRequestObject = new XMLHttpRequest();
          else if (window.ActiveXobject)
            XMLHttpRequestObject = new ActiveXObject("Microsoft.XMLHTTP");

          if (XMLHttpRequestObject) {
            XMLHttpRequestObject.open('GET', "/room/${room.getRoomName()}/${room.getId()}/${user.getId()}", true);
            XMLHttpRequestObject.responseType = 'document';
            XMLHttpRequestObject.onreadystatechange = function () {
              if (XMLHttpRequestObject.readyState == 4 && XMLHttpRequestObject.status == 200) {
                xmlDocument = XMLHttpRequestObject.responseXML;
                document.getElementById('updateRoomName').innerHTML = xmlDocument.getElementById('updateRoomName').innerHTML;
                console.log("Update list message");
              }
            }
            XMLHttpRequestObject.send(null);
          }
        }
      }, 2000);
    </script>
    <script type='text/javascript'>
      var xmlDocument;
      setInterval(function upd() {
        var formMessageCreate = document.getElementById('AddMessageForm');

        formMessageCreate.onsubmit = function refresh(event) {

          var MesHeader = document.getElementById('MesHeaderCreation');
          var valMesHeader = MesHeader.value;

          var MesTheme = document.getElementById('MesThemeCreation');
          var valMesTheme = MesTheme.value;

          var MesTypeSport = document.getElementById('selectMesCreation');
          var valMesTypeSport = MesTypeSport.value;

          var MesText = document.getElementById('MesTextCreation');
          var valMesText = MesText.value;

          var MesFile = document.getElementById('customFile');
          var valMesFile = MesFile.value;

          if (valMesFile == "") {
            var data = {
              header: valMesHeader,
              theme: valMesTheme,
              text: valMesText,
              activityType: valMesTypeSport,
            };

            var boundary = String(Math.random()).slice(5);
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
              XMLHttpRequestObject.open('POST', "/room/${room.getRoomName()}/${room.getId()}/${user.getId()}", true);
              XMLHttpRequestObject.setRequestHeader('X-CSRF-Token', document.getElementById('_csrfMesCreation').value);
              XMLHttpRequestObject.setRequestHeader('Content-Type', 'multipart/form-data; boundary=' + boundary);
              XMLHttpRequestObject.responseType = 'document';
              XMLHttpRequestObject.onreadystatechange = function () {
                if (XMLHttpRequestObject.readyState == 4 && XMLHttpRequestObject.status == 200) {
                  xmlDocument = XMLHttpRequestObject.responseXML;
                  document.getElementById('updateRoomName').innerHTML = xmlDocument.getElementById('updateRoomName').innerHTML;
                  console.log("Update list message after added");
                }
              }
              XMLHttpRequestObject.send(body);
              MesHeader.value = "";
              MesTheme.value = "";
              MesText.value = "";
            }
          }
        };
      }, 500);
    </script>
  </@c.page>