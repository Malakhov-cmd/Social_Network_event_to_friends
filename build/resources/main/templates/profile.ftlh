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
    <div class="container mt-5 mb-5">
      <div class="row">
        <div class="col align-self-center">
          <p class="lead"> Dialog list </p>
        </div>
      </div>
    </div>
    <table class="table table-striped mt-6">
      <thead>
        <tr>
          <th scope="col">#</th>
          <th scope="col">Username</th>
          <th scope="col">Id</th>
        </tr>
      </thead>
      <tbody>
        <#list userList as user>
        <tr>
          <th scope="row">${user_index}</th>
          <td>${user.username}</td>
          <td>${user.id}</td>
        </tr>
        </#list>
      </tbody>
    </table>
  </@c.page>
