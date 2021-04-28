<#import "parts/common.ftlh" as c>
<@c.page>
        <div class="form-row">
        <div class="form-group col-md-6">
                  <form method="get" action="/main" class="form-inline">
                        <input type="text" name="filter" value="${filter?ifExists}" class="form-control" placeholder="Search">
                        <button type="submit" class="btn btn-primary ml-2">find</button>
                  </form>
        </div>
        </div>
         <a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
            Add new message
          </a>
        <div class="collapse" id="collapseExample">
            <div class="form-group mb-3">
                  <form method="POST" enctype="multipart/form-data">
                    <div class="form-group mt-4">
                    <input type="text" class="form-control" name="header" placeholder="Enter header to you post">
                    </div>
                    <div class="form-group">
                    <input type="text" class="form-control" name="theme" placeholder="Enter theme to you post">
                    </div>
                    <div class="form-group">
                    <input type="text" class="form-control" name="text" placeholder="Enter text to you post">
                    </div>
                    <div class="form-group">
                    <div class="custom-file">
                        <input type="file" id="customFile" name="file">
                        <label class="custom-file-label" for="customFile">Choose file</label>
                    </div>
                    </div>
                    <div class="form-group">
                    <input type="text" class="form-control" name="date" placeholder="Enter date to you post">
                    </div>
                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>

                    <div class="form-group">
                    <button type="submit" class="btn btn-primary ml-2">Add</button>
                    </div>
                  </form>
            </div>
        </div>
    <div>
    <div class="card-columns">
            <#list messages as message>
                    <div class="card my-3">
                    <#if message.filename??>
                          <img src="/img/${message.filename}" class="card-img-top">
                    </#if>
                    <h5 class="card-title">${message.getHeader()}</h5>
                    <div class="m-2">
                         ${message.getTheme()}
                         <span>${message.getText()}</span>
                          <i>${message.getDate()}</i>
                    </div>
                    <div class="card-footer text-muted">
                          <strong>${message.getAuthorName()}</strong>
                    </div>
                    </div>
                    <#else>
                    No messages yet
            </#list>
    </div>
    </div>
</@c.page>