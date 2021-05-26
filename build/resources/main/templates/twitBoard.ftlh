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
              <form method="POST">
                <div class="form-group">
                  <input type="text" class="form-control  ${(themeError??)?string('is-invalid', '')}" name="theme"
                    placeholder="Enter theme to you post" value="<#if message??>${twitMessage.theme}</#if>">
                  <#if themeError??>
                    <div class="invalid-feedback">
                      ${themeError}
                    </div>
                  </#if>
                </div>
                <div class="form-group">
                  <input type="text" class="form-control ${(textError??)?string('is-invalid', '')}" name="text"
                    placeholder="Enter text to you post" value="<#if message??>${twitMessage.text}</#if>">
                  <#if textError??>
                    <div class="invalid-feedback">
                      ${textError}
                    </div>
                  </#if>
                </div>
                <input type="hidden" name="_csrf" value="${_csrf.token}" />
                <div class="form-group">
                  <button type="submit" class="btn btn-primary ml-2">Add</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>

    <#if twitMessageSize!=0>
      <#list twitMessage as message>

        <div class="card mb-3 mt-4">
          <h5 class="card-header">${message.getTheme()}</h5>
          <div class="card-body">
            <p class="card-text">${message.getText()}</p>
            <strong>
              <em>${message.getDate()}</em>
            </strong>
          </div>
          <div class="card-footer">
            <div class="form-group text-right">
              <form action="/messageLike" method="POST">
                <input type="hidden" name="_csrf" value="${_csrf.token}" />
                <input type="hidden" name="twitMessageLiked" value="${message.getId()}" />
                <input type="hidden" name="twitUserToReturn" value="${user.getId()}" />
                <button type="submit" class="btn btn-primary ml-2"><i class="fa fa-heart" aria-hidden="true"></i><em>
                    ${message.getLikesCount()}</em></button>
              </form>
            </div>
            <div class="accordion" id="aa${message.getId()}">
              <div class="card">
                <div class="card-header" id="aa${message.getUuid1()}">
                  <h5 class="mb-0">
                    <button class="btn btn-link collapsed" type="button" data-toggle="collapse"
                      data-target="#aa${message.getUuid2()}" aria-expanded="false"
                      aria-controls="aa${message.getUuid2()}">
                      Comments
                    </button>
                  </h5>
                </div>
                <div id="aa${message.getUuid2()}" class="collapse" aria-labelledby="aa${message.getUuid1()}"
                  data-parent="#aa${message.getId()}">
                  <div class="card-body">
                    <div class="form-group mb-3">
                      <div class="form-group">
                        <form action="/addComment" method="POST">

                          <label for="inputCommentText">Comment input</label>
                          <input type="text" class="form-control mt-2 mb-3" name="commentText" id="inputCommentText">
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
                            </div>
                          </div>
                        </#list>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </#list>
      <#else>
        No dialogs yet
    </#if>
  </@c.page>