<#import "parts/common.ftlh" as c>
  <@c.page>
    <div id="updateRequest">
      <#list futureFriendRequest as futureFriend>
        <div class="card mb-4">
          <div class="card-header" id=${futureFriend_index}>
            <h5 class="mb-0">
              <p>Request ${futureFriend_index}</p>
            </h5>
          </div>

          <div class="card-body">
            <img src="https://springeventmanager.s3.us-east-2.amazonaws.com/${futureFriend.avatarFilename}"
              class="card-img-top">
            <ul class="list-group list-group-flush bg-light">
              <li class="list-group-item bg-light">
                <div class="card-text m-2">
                  <span>${futureFriend.username}</span>
                </div>
              </li>
              <li class="list-group-item bg-light">
                <p class="card-text">
                  <small>
                    <i><em>${futureFriend.id}</em></i>
                  </small>
                </p>
              </li>
              <li class="list-group-item bg-light">
                <form method="POST" enctype="multipart/form-data" class="cls_FriendRequest">
                  <label for="input_text1">Its friend?</label>
                  <div class="form-group ">
                    <select class="cls_FriendDesitionSelected custom-select " name="design">
                      <option selected>Desition</option>
                      <option value="add">Add</option>
                      <option value="reject">Reject</option>
                      <option value="noting">Put aside</option>
                    </select>
                  </div>
                  <input type="hidden" name="_csrf" value="${_csrf.token}" class="cls__csrfReq" />
                  <input hidden name="secondUser" value=${futureFriend.id} class="cls_SecondUsr">
                  <div class="form-group">
                    <button type="submit" class="btn btn-primary ml-2">Confirm</button>
                  </div>
                </form>
              </li>
            </ul>
          </div>
        </div>
      </#list>
    </div>
    <script type='text/javascript'>
      var xmlDocument;
      setInterval(function upd() {
        var formFriendRequest = document.querySelectorAll('.cls_FriendRequest').forEach((elem, index) => {
          elem.onsubmit = function refresh(event) {
            event.preventDefault();

            var RequiredDesign = elem.querySelector('.cls_FriendDesitionSelected');
            var valRequiredDesign = RequiredDesign.value;

            var RequiredSecondUsr = elem.querySelector('.cls_SecondUsr');
            var valRequiredSecondUsr = RequiredSecondUsr.value;

            if (valRequiredDesign === "noting") {
              window.scrollTo(0, 0);
              console.log("Scroll");
            } else {
              if (valRequiredDesign != "" && valRequiredDesign != "Desition") {
                var data = {
                  design: valRequiredDesign,
                  secondUser: valRequiredSecondUsr,
                };

                var boundary = String(Math.random()).slice(2);
                var boundaryMiddle = '--' + boundary + '\r\n';
                var boundaryLast = '--' + boundary + '--\r\n';

                var body = ['\r\n'];
                for (var key in data) {
                  body.push('Content-Disposition: form-data; name="' + key + '"\r\n\r\n' + data[key] + '\r\n');
                }

                body = body.join(boundaryMiddle) + boundaryLast;

                var XMLHttpRequestObject = false;
                if (window.XMLHttpRequest)
                  XMLHttpRequestObject = new XMLHttpRequest();
                else if (window.ActiveXobject)
                  XMLHttpRequestObject = new ActiveXObject("Microsoft.XMLHTTP");

                if (XMLHttpRequestObject) {
                  XMLHttpRequestObject.open('POST', "/confirmationrequest/${user.getId()}", true);
                  XMLHttpRequestObject.setRequestHeader('X-CSRF-Token', elem.querySelector('.cls__csrfReq').value);
                  XMLHttpRequestObject.setRequestHeader('Content-Type', 'multipart/form-data; boundary=' + boundary);
                  XMLHttpRequestObject.responseType = 'document';
                  XMLHttpRequestObject.onreadystatechange = function () {
                    if (XMLHttpRequestObject.readyState == 4 && XMLHttpRequestObject.status == 200) {
                      xmlDocument = XMLHttpRequestObject.responseXML;
                      document.getElementById('updateRequest').innerHTML = xmlDocument.getElementById('updateRequest').innerHTML;
                      console.log("Update vote");
                    }
                  }
                  XMLHttpRequestObject.send(body);
                }
              }
            }
          };
        });
      }, 500);
    </script>
  </@c.page>