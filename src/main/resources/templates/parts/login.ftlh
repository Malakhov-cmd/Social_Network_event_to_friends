<#macro login path isRegisterForm>
  <form action="${path}" method="post" enctype="multipart/form-data">
    <div class="form-group row">
      <label class="col-sm-2 col-form-label"> User Name : </label>
      <div class="col-sm-10">
        <input type="text" name="username" class="form-control  ${(usernameError??)?string('is-invalid', '')}"
          placeholder="User name" value="<#if userError??>${user.username}</#if>" />
        <#if usernameError??>
          <div class="invalid-feedback">
            ${usernameError}
          </div>
        </#if>
      </div>
    </div>
    <div class="form-group row">
      <label class="col-sm-2 col-form-label"> Password: </label>
      <div class="col-sm-10">
        <input type="password" name="password" class="form-control ${(passwordError??)?string('is-invalid', '')}"
          placeholder="Password" value="<#if passwordError??>${user.password}</#if>" />
        <#if passwordError??>
          <div class="invalid-feedback">
            ${passwordError}
          </div>
        </#if>
      </div>
    </div>
    <#if isRegisterForm>
      <div class="form-group">
        <div class="custom-file">
          <input type="file" id="customFile" name="avatar">
          <label class="custom-file-label" for="customFile">Choose avatar photo in images format</label>
        </div>
        <#if FormatException??>
          <label class="col-sm-2 col-form-label">${FormatException}</label>
        </#if>
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