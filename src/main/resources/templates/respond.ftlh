<#import "parts/common.ftlh" as c>
  <@c.page>
    <#list userRespond as respond>
      <div class="card">
        <div class="card-header" id=${respond_index}>
          <h5 class="mb-0">
            <p>Request ${respond_index}</p>
          </h5>
        </div>
        <div class="card-body">
          <img src="https://springeventmanager.s3.us-east-2.amazonaws.com/${respond.avatarFilename}" class="card-img-top">
          <ul class="list-group list-group-flush bg-light">
            <li class="list-group-item bg-light">
              <div class="card-text m-2">
                <span>${respond.username}</span>
              </div>
            </li>
            <li class="list-group-item bg-light">
              <p class="card-text">
                <small>
                  <i><em>${respond.id}</em></i>
                </small>
              </p>
            </li>
          </ul>
        </div>
      </div>
    </#list>
  </@c.page>