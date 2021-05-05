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
            <img src="/img/${user.avatarFilename}" width="250" height="150" class="rounded" alt="Avatar">
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
      </form>
      <button type="button" class="btn btn-primary"
        onclick="window.location.href='/dialogs/${user.id}'; return false">Dialogs</button>
      <form method="post">
        <div class="form-group">
          <label for="findFriend">Find friend</label>
          <textarea class="form-control" id="findFriend" rows="1" name="friendId"></textarea>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <div class="form-group">
          <button type="submit" class="btn btn-primary ml-2">Find</button>
        </div>
      </form>
      <div class="container mt-5 mb-5">
        <div class="row">
          <div class="col align-self-center">
            <p class="lead"> Dialog list </p>
          </div>
        </div>
      </div>
      <table class="table table-hover mt-6">
        <thead>
          <tr>
            <th scope="col">#</th>
            <th scope="col">Username</th>
            <th scope="col">Id</th>
          </tr>
        </thead>
        <tbody>
          <#list friendList as friend>
            <tr onclick="window.location.href='/profile/${friend.id}'; return false">
              <th scope="row">${friend_index}</th>
              <td>${friend.username}</td>
              <td>${friend.id}</td>
            </tr>
          </#list>
        </tbody>
      </table>
    </@c.page>
