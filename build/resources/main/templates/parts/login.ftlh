  <#macro login path isRegisterForm>
    <form action="${path}" method="post" enctype="multipart/form-data">
      <div class="form-group row">
        <label class="col-sm-2 col-form-label"> User Name : </label>
        <div class="col-sm-10">
          <input type="text" name="username" class="form-control" placeholder="User name" />
        </div>
      </div>
      <div class="form-group row">
        <label class="col-sm-2 col-form-label"> Password: </label>
        <div class="col-sm-10">
          <input type="password" name="password" class="form-control" placeholder="Password" />
        </div>
      </div>
      <#if isRegisterForm>
        <div class="form-group">
          <div class="custom-file">
            <input type="file" id="customFile" name="avatar">
            <label class="custom-file-label" for="customFile">Choose file</label>
          </div>
        </div>
      </#if>
      <#if !isRegisterForm><a href="/registration">Add new user</a></#if>
      <button type="submit" class="btn btn-primary">Sign in</button>
      <input type="hidden" name="_csrf" value="${_csrf.token}" />
    </form>
  </#macro>

  <#macro logout>
    <form action="/logout" method="post">
      <button type="submit" class="btn btn-primary ml-2">Sign out</button>
      <input type="hidden" name="_csrf" value="${_csrf.token}" />
    </form>
  </#macro>