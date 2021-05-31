<#import "parts/common.ftlh" as c>
  <@c.page>
    <script src="https://use.fontawesome.com/712d2bbdad.js"></script>
    <div class="accordion" id="accordionExample">
      <div class="card">
        <div class="card-header" id="headingTwo">
          <h5 class="mb-0">
            <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo"
              aria-expanded="false" aria-controls="collapseTwo">
              Add some news
            </button>
          </h5>
        </div>
        <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionExample">
          <div class="card-body">
            <div class="form-group mb-3">
              <form method="POST" id="form_createTwit" enctype="multipart/form-data">
                <div class="form-group">
                  <input type="text" class="form-control  ${(themeError??)?string('is-invalid', '')}" name="theme"
                    id="twitTheme" placeholder="Enter theme to you post"
                    value="<#if message??>${twitMessage.theme}</#if>">
                  <#if themeError??>
                    <div class="invalid-feedback">
                      ${themeError}
                    </div>
                  </#if>
                </div>
                <div class="form-group">
                  <input type="text" class="form-control ${(textError??)?string('is-invalid', '')}" name="text"
                    id="twitText" placeholder="Enter text to you post" value="<#if message??>${twitMessage.text}</#if>">
                  <#if textError??>
                    <div class="invalid-feedback">
                      ${textError}
                    </div>
                  </#if>
                </div>
                <label for="twitMesFilename">add picture if you need</label>
                <div class="form-group" id="twitMesFilename">
                  <div class="custom-file">
                    <input type="file" id="customFile" name="twitFileMessageFile">
                    <label class="custom-file-label" for="customFile">Choose file</label>
                  </div>
                  <#if FileMessageError??>
                    <label class="col-sm-2 col-form-label">${FileMessageError}</label>
                  </#if>
                </div>
                <input type="hidden" name="_csrf" value="${_csrf.token}" id="_csrfAddTwit" />
                <div class="form-group">
                  <button type="submit" class="btn btn-primary ml-2">Add</button>
                </div>
                <script type='text/javascript'>
                  var xmlDocument;
                  var formTwitCreate = document.getElementById('form_createTwit');

                  formTwitCreate.onsubmit = function refresh(event) {

                    var textNewTwitThemeValue = document.getElementById('twitTheme');
                    var valTwitThemeName = textNewTwitThemeValue.value;

                    var textNewTwitTextValue = document.getElementById('twitText');
                    var valTwitTextList = textNewTwitTextValue.value;

                    var textNewTwitFileValue = document.getElementById('customFile');
                    var valTwitFile = textNewTwitFileValue.value;
                    if (valTwitFile == "") {
                      var data = {
                        theme: valTwitThemeName,
                        text: valTwitTextList,
                      };

                      var boundary = String(Math.random()).slice(3);
                      var boundaryMiddle = '--' + boundary + '\r\n';
                      var boundaryLast = '--' + boundary + '--\r\n';

                      var body = ['\r\n'];
                      for (var key in data) {
                        // добавление поля
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
                        XMLHttpRequestObject.open('POST', "/twitboard/${user.getId()}", true);
                        XMLHttpRequestObject.setRequestHeader('X-CSRF-Token', document.getElementById('_csrfAddTwit').value);
                        XMLHttpRequestObject.setRequestHeader('Content-Type', 'multipart/form-data; boundary=' + boundary);
                        XMLHttpRequestObject.responseType = 'document';
                        XMLHttpRequestObject.onreadystatechange = function () {
                          if (XMLHttpRequestObject.readyState == 4 && XMLHttpRequestObject.status == 200) {
                            xmlDocument = XMLHttpRequestObject.responseXML;
                            document.getElementById('updateTwitBoad').innerHTML = xmlDocument.getElementById('updateTwitBoad').innerHTML;
                            console.log("Update twit board");
                          }
                        }
                        XMLHttpRequestObject.send(body);
                      }
                    }
                  };
                </script>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div id="updateTwitBoad">
      <#if twitMessageSize!=0>
        <#list twitMessage as message>

          <div class="card mb-3 mt-4">
            <#if message.filename??>
              <img src="https://springeventmanager.s3.us-east-2.amazonaws.com/${message.filename}" class="card-img-top">
            </#if>
            <h5 class="card-header">${message.getTheme()}</h5>
            <div class="card-body">
              <p class="card-text">${message.getText()}</p>
              <strong>
                <em>${message.getDate()}</em>
              </strong>
            </div>
            <div class="card-footer">
              <em>${message.getAuthorName()}</em>
              <div class="form-group text-right">
                <form action="/messageLike" method="POST" id="form_twitLike" class="cls_form_twitLike">
                  <input type="hidden" name="_csrf" value="${_csrf.token}" id="csrf_twitLike" class="_csrf_twitLike" />

                  <input type="hidden" name="twitMessageLiked" value="${message.getId()}" id="formTwitFinder"
                    class="cls_twit_MessageLiked" />
                  <input type="hidden" name="formTwitFinder" value="twit_MessageLiked${message.getId()}"
                    id="formTwitFinder" />

                  <input type="hidden" name="twitUserToReturn" value="${user.getId()}" id="formUserFinder"
                    class="cls_twit_MessageUser" />
                  <input type="hidden" name="formUserFinder" value="twit_userToreturn${message.getId()}"
                    id="formUserFinder" />
                  <button type="submit" class="btn btn-primary ml-2">
                    <i class="fa fa-heart" aria-hidden="true"></i>
                    <em id="update_twitLike" class="cls_update_twitLike">
                      ${message.getLikesCount()}
                    </em>
                  </button>

                </form>
              </div>
              <div class="accordion" id="aa${message.getId()}">
                <div class="card">
                  <div class="card-header" id="aa${message.getUuid1()}">
                    <h5 class="mb-0">
                      <button class="btn btn-link collapsed" type="button" data-toggle="collapse"
                        data-target="#aa${message.getUuid2()}" aria-expanded="false"
                        aria-controls="aa${message.getUuid2()}">
                        <i class="fa fa-comments" aria-hidden="true"></i> Comments
                      </button>
                    </h5>
                  </div>
                  <div id="aa${message.getUuid2()}" class="collapse" aria-labelledby="aa${message.getUuid1()}"
                    data-parent="#aa${message.getId()}">
                    <div class="card-body">
                      <div class="form-group mb-3">
                        <div class="form-group">
                          <form action="/addComment" method="POST" enctype="multipart/form-data">

                            <label for="inputCommentText">Comment input</label>
                            <input type="text"
                              class="form-control mt-2 mb-3 ${(commentTextError??)?string('is-invalid', '')}"
                              name="commentText" id="inputCommentText"
                              value="<#if twitMessageComment??>${twitMessageComment.commentText}</#if>">
                            <#if commentTextError??>
                              <div class="invalid-feedback">
                                ${commentTextError}
                              </div>
                            </#if>

                            <label for="twitMesCommentFilename">add picture if you need</label>
                            <div class="form-group" id="twitMesCommentFilename">
                              <div class="custom-file">
                                <input type="file" id="customFileComment" name="twitFileMessageCommentFile">
                                <label class="custom-file-label" for="customFileComment">Choose file</label>
                              </div>
                            </div>
                            <#if FileMessageCommentError??>
                              <label class="col-sm-2 col-form-label">${FileMessageCommentError}</label>
                            </#if>

                            <input type="hidden" name="twitMessageRequaredTocomment" value="${message.getId()}" />
                            <input type="hidden" name="twitBoardreqiaredToComment" value="${user.getIdBoard()}" />
                            <input type="hidden" name="twitUserToreturn" value="${user.getId()}" />
                            <input type="hidden" name="_csrf" value="${_csrf.token}" />

                            <button type="submit" class="btn btn-primary ml-2">Add</button>
                          </form>
                        </div>

                        <div class="form-group">
                          <#list message.getTwitBoardMessageComments() as comment>
                            <div class="card mb-3">
                              <#if comment.filename??>
                                <img src="https://springeventmanager.s3.us-east-2.amazonaws.com/${comment.filename}"
                                  class="card-img-top">
                              </#if>
                              <h5 class="card-header">${comment.getAuthorComment().getUsername()}</h5>
                              <div class="card-body">
                                <p class="card-text">${comment.getTextComment()}</p>
                                <strong>
                                  <em>${comment.getDateComment()}</em>
                                </strong>
                              </div>
                              <div class="card-footer">
                                <div class="form-group text-right">
                                  <form action="/commentLike" method="POST">
                                    <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                    <input type="hidden" name="twitCommentLiked" value="${comment.getId()}" />
                                    <input type="hidden" name="twitUserToReturn" value="${user.getId()}" />
                                    <button type="submit" class="btn btn-primary ml-2"><i class="fa fa-heart"
                                        aria-hidden="true"></i> <em> ${comment.getCommentLikesCount()}</em> </button>
                                  </form>
                                </div>
                                <#if currentUserId=comment.getAuthorId()>
                                  <form action="/deleteComment" method="POST">
                                    <input type="hidden" name="_csrf" value="${_csrf.token}" />
                                    <input type="hidden" name="twitCommentDelete" value="${comment.getId()}" />
                                    <input type="hidden" name="twitCommentDeleteAuthorId" value=${user.getId()} />
                                    <input type="hidden" name="boardMessageCommentToDelete" value=${message.getId()} />
                                    <button type="submit" class="btn btn-primary ml-2 mt-2">Delete</button>
                                  </form>
                                </#if>
                              </div>
                            </div>
                          </#list>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <#if currentUserId=message.getIdAuthor()>
                <form action="/deleteTwit" method="POST">
                  <input type="hidden" name="_csrf" value="${_csrf.token}" />
                  <input type="hidden" name="twitDelete" value="${message.getId()}" />
                  <input type="hidden" name="twitDeleteAuthorId" value=${currentUserId} />
                  <input type="hidden" name="boardToDelete" value=${user.getId()} />
                  <button type="submit" class="btn btn-primary ml-2 mt-2">Delete</button>
                </form>
              </#if>
            </div>
          </div>
        </#list>
        <#else>
          No dialogs yet
      </#if>
    </div>
    <script type='text/javascript'>
      var xmlDocument;
      var formTwitLike = document.querySelectorAll('.cls_form_twitLike').forEach((elem, index) => {
        console.log(index);
        elem.onsubmit = function refresh(event) {

          var textTwitReturnValue = elem.querySelector('.cls_twit_MessageLiked');
          var valTwitReturn = textTwitReturnValue.value;

          var textTwitUserToReturnValue = elem.querySelector('.cls_twit_MessageUser');
          var valUserReturn = textTwitUserToReturnValue.value;

          event.preventDefault();
          var XMLHttpRequestObject = false;
          if (window.XMLHttpRequest)
            XMLHttpRequestObject = new XMLHttpRequest();
          else if (window.ActiveXobject)
            XMLHttpRequestObject = new ActiveXObject("Microsoft.XMLHTTP");

          if (XMLHttpRequestObject) {
            XMLHttpRequestObject.open('POST', "/messageLike", true);
            XMLHttpRequestObject.setRequestHeader('X-CSRF-Token', elem.querySelector('._csrf_twitLike').value);
            XMLHttpRequestObject.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            XMLHttpRequestObject.responseType = 'document';
            XMLHttpRequestObject.onreadystatechange = function () {
              if (XMLHttpRequestObject.readyState == 4 && XMLHttpRequestObject.status == 200) {
                xmlDocument = XMLHttpRequestObject.responseXML;

                var responseLikes = xmlDocument.querySelectorAll('.cls_update_twitLike').forEach((like, indexLike) => {
                    if(indexLike === index){
                      elem.querySelector('.cls_update_twitLike').innerHTML = like.innerHTML;
                      console.log("Update twit like");
                    }
                });
              }
            }
            XMLHttpRequestObject.send("twitMessageLiked=" + valTwitReturn + "&twitUserToReturn=" + valUserReturn);
          }
          //textNewFriendValue.value = "";
        };
      });
    </script>
  </@c.page>