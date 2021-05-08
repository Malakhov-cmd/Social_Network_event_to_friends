<#import "parts/common.ftlh" as c>
  <@c.page>
    <#if roomsSize!=0>
      <#list rooms as room>
        <div class="card mb-3">
          <h5 class="card-header">${room.getRoomName()}</h5>
          <div class="card-body">
            <h5 class="card-title">Creator: @${room.getAdmin().getUsername()}</h5>
            <label for="membersList">Members: </label>
            <div id="membersList">
              <#if room.getParticipants()?size !=0>
                <#list room.getParticipants() as member>
                   <p class="card-text">${member.getUsername()}</p>
                </#list>
                <#else>
                  <p class="card-text">Is only admin</p>
              </#if>
              <a href="/room/${room.getRoomName()}/${room.getId()}/${user.getId()}" class="btn btn-primary">Go to room</a>
            </div>
          </div>
        </div>
      </#list>
      <#else>
        No rooms yet
    </#if>
  </@c.page>