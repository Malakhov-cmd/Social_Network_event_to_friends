<#import "parts/common.ftlh" as c>
  <@c.page>
    <script src="https://use.fontawesome.com/712d2bbdad.js"></script>
    <#if roomsSize!=0>
      <#list rooms as room>
        <div class="card mt-3 mb-4">
          <h5 class="card-header">${room.getRoomName()}</h5>
          <div class="card-body">
            <h5 class="card-title"><i class="fa fa-user-circle" aria-hidden="true"></i> Creator:
              @${room.getAdmin().getUsername()}</h5>
            <label for="membersList">Members: </label>
            <div id="membersList">
              <#if room.getParticipants()?size !=0>
                <#list room.getParticipants() as member>
                  <p class="card-text">
                    <button type="button" class="btn btn-light card-text"
                      onclick="window.location.href='/profile/${member.id}'; return false">${member.getUsername()}</button>
                  </p>
                </#list>
              </#if>
            </div>
            <a href="/room/${room.getRoomName()}/${room.getId()}/${user.getId()}" class="btn btn-primary mt-3">Go to
              room</a>
          </div>
        </div>
      </#list>
      <#else>
        No rooms yet
    </#if>
  </@c.page>