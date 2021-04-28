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
        <ul>
            <#list messages as message>
                    <li>
                        ${message.getId()} ${message.getHeader()} ${message.getTheme()} ${message.getText()} ${message.getDate()} <strong>${message.getAuthorName()}</strong>
                        <div>
                            <#if message.filename??>
                                <img src="/img/${message.filename}">
                            </#if>
                        </div>
                    </li>
                    <#else>
                    No messages yet
            </#list>
        </ul>
    </div>
</@c.page>