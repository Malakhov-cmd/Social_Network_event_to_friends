<#assign known=Session.SPRING_SECURITY_CONTEXT??>
  <#if known>
    <#assign currentUser=Session.SPRING_SECURITY_CONTEXT.authentication.principal name=currentUser.getUsername()
      currentUserId=currentUser.getId() isAdmin=currentUser.isAdmin()>
      <#else>
        <#assign name="unknown" isAdmin=false currentUserId=-1>
  </#if>

  <#import "parts/common.ftlh" as c>
    <@c.page>
      <div class="container mt-5 mb-5">
        <div class="row">
          <div class="col align-self-center">
            <p class="lead"> Profile </p>
          </div>
        </div>
      </div>
      <form>
        <div class="form-group row">
          <#if user.hasAvatar()==true>
            <img src="https://springeventmanager.s3.us-east-2.amazonaws.com/${user.avatarFilename}" width="250" height="250" class="rounded" alt="Avatar">
          </#if>
        </div>
        <div class="form-group row">
          <div class="input-group">
            <div class="input-group-prepend">
              <span class="input-group-text">Username</span>
            </div>
            <input type="text" readonly aria-label="First name" class="form-control" value="${user.getUsername()}">
          </div>
        </div>
        <div class="form-group row">
          <div class="input-group">
            <div class="input-group-prepend">
              <span class="input-group-text">Id</span>
            </div>
            <input type="text" readonly aria-label="First name" class="form-control" value="${user.getId()}">
          </div>
        </div>
        <div class="form-group row">
          <div class="input-group">
            <div class="input-group-prepend">
              <span class="input-group-text">Rank</span>
            </div>
            <#if user.isAdmin()==true>
              <input type="text" readonly aria-label="First name" class="form-control" value="Admin">
              <#else>
                <input type="text" readonly aria-label="First name" class="form-control" value="User">
            </#if>
          </div>
        </div>
        <#if currentUser.id==user.id>
          <ul class="list-group">
            <li class="list-group-item d-flex justify-content-between align-items-center">
              <button type="button" class="btn btn-primary"
                onclick="window.location.href='/confirmationrequest/${user.id}'; return false">
                Request friend
                <span class="badge badge-primary badge-pill">${requestFriendCount}</span>
                <span class="sr-only">unread messages</span>
              </button>
            </li>
            <li class="list-group-item d-flex justify-content-between align-items-center">
              <button type="button" class="btn btn-primary"
                onclick="window.location.href='/respondlist/${user.id}'; return false">
                Respond friend
                <span class="badge badge-primary badge-pill">${respondFriendCount}</span>
                <span class="sr-only">unread messages</span>
              </button>
            </li>
          </ul>
        </#if>
      </form>
      <#if currentUser.id==user.id>
        <button type="button" class="btn btn-primary btn-lg btn-block"
          onclick="window.location.href='/dialogs/${user.id}'; return false">Dialogs</button>
        <form method="post">
          <div class="form-group mt-3">
            <label for="newDialog">Start new dialog</label>
            <textarea class="form-control" id="newDialog" rows="1" name="userToDialog" placeholder="Enter user id"></textarea>
          </div>
          <input type="hidden" name="_csrf" value="${_csrf.token}" />
          <div class="form-group">
            <button type="submit" class="btn btn-primary ml-2">Create</button>
          </div>
          <#if userToCreateDialogNotFounded==true>
            <p>User not founded or you try to talk with yourself</p>
          </#if>
        </form>
        <form method="post">
          <div class="form-group">
            <label for="findFriend">Find friend</label>
            <textarea class="form-control" id="findFriend" rows="1" name="friendId" placeholder="Enter user id"></textarea>
          </div>
          <input type="hidden" name="_csrf" value="${_csrf.token}" />
          <div class="form-group">
            <button type="submit" class="btn btn-primary ml-2">Find</button>
          </div>
        </form>

        <div class="accordion" id="accordionExample">
          <div class="card">
            <div class="card-header" id="headingOne">
              <h5 class="mb-0">
                <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapseOne"
                  aria-expanded="true" aria-controls="collapseOne">
                  Create room
                </button>
              </h5>
            </div>

            <div id="collapseOne" class="collapse" aria-labelledby="headingOne" data-parent="#accordionExample">
              <div class="card-body">
                <form method="post">
                  <div class="form-group">
                    <label for="roomName">Room name</label>
                    <textarea class="form-control" id="roomName" rows="1" name="roomName"></textarea>
                  </div>

                  <div>
                    <input type="text" hidden name="strFriendToRoom" class="placeHold">
                  </div>

                  <div class="frientSelected">
                  <label for="friendListDisplay">Friends</label>
                    <div class="form-group" id="friendListDisplay">
                      <#if FriendListSize!=0>
                        <#list friendList as friend>
                          <div class="input-group">
                            <div class="input-group-prepend">
                              <div class="input-group-text">
                                <input type="checkbox" class="inputFriend" id="${friend_index}"
                                  aria-label="Checkbox for following text input" value="${friend.username} ">
                              </div>
                            </div>
                            <input type="text" readonly class="form-control" aria-label="Text input with checkbox"
                              value="${friend.username}">
                          </div>
                        </#list>
                      </#if>
                    </div>
                  </div>
                  <input type="hidden" name="_csrf" value="${_csrf.token}" />
                  <div class="form-group">
                    <button type="submit" class="btn btn-primary ml-2">Create</button>
                  </div>
                </form>
              </div>
            </div>
          </div>
          <div class="container mt-5 mb-5">
            <div class="row">
              <div class="col align-self-center">
                <p class="lead"> Friend list </p>
              </div>
            </div>
          </div>
      </#if>
      <#if currentUser.id!=user.id && isFriend==true>
        <form method="post">
          <div class="form-group">
            <label for="deleteFriend">Delete from friend</label>
          </div>
          <input type="hidden" name="_csrf" value="${_csrf.token}" />
          <div class="form-group">
            <button type="submit" id="deleteFriend" class="btn btn-primary ml-2">Delete</button>
          </div>
        </form>
      </#if>
      <table class="table table-hover mt-6">
        <thead>
          <tr>
            <th scope="col">#</th>
            <th scope="col">Username</th>
            <th scope="col">Id</th>
          </tr>
        </thead>
        <tbody>
          <#if FriendListSize!=0>
            <#list friendList as friend>
              <tr onclick="window.location.href='/profile/${friend.id}'; return false">
                <th scope="row">${friend_index}</th>
                <td>${friend.username}</td>
                <td>${friend.id}</td>
              </tr>
            </#list>
          </#if>
        </tbody>
      </table>
      <script>
        const inputs = document.querySelectorAll('.inputFriend');
        console.log(inputs.length);
        const placeHold = document.querySelector('.placeHold');
        console.log("Hello")
        inputs.forEach(el => {
          el.addEventListener('click', () => {
            placeHold.value = '';

            let input_checkeds = document.querySelectorAll('input:checked');
            console.log(input_checkeds.length);


            input_checkeds.forEach(el_checked => {
              //placeHold.insertAdjacentHTML('beforeend', el_checked.value);
              placeHold.value = placeHold.value +  el_checked.value;
            });
          });
        });
      </script>
    </@c.page>