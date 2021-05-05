<#import "parts/common.ftlh" as c>
  <@c.page>
      <#list futureFriendRequest as futureFriend>
        <div class="card">
          <div class="card-header" id=${futureFriend_index}>
            <h5 class="mb-0">
                <p>Request ${futureFriend_index}</p>
            </h5>
          </div>

            <div class="card-body">
              <img src="/img/${futureFriend.avatarFilename}" class="card-img-top">
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
                <div class="form-row">
                  <div class="form-group col-md-6">
                    <form method="POST" enctype="multipart/form-data">
                      <label for="input_text1">Its friend?</label>
                      <div class="form-group">
                        <div class="btn-group" role="group" aria-label="Basic example">
                          <button type="submit" class="btn btn-primary ml-2" name="design" value="add">Add</button>
                          <button type="submit" class="btn btn-primary ml-2" name="design"
                            value="reject">Reject</button>
                          <button type="submit" class="btn btn-primary ml-2" name="design" value="noting">Put
                            aside</button>
                          <input type="hidden" name="_csrf" value="${_csrf.token}" />
                          <input hidden name="secondUser" value=${futureFriend.id}>
                        </div>
                      </div>
                    </form>
                  </div>
                </div>
              </ul>
            </div>
          </div>
      </#list>
  </@c.page>