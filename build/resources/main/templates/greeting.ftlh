<#import "parts/common.ftlh" as c>
  <@c.page>
  <script src="https://use.fontawesome.com/712d2bbdad.js"></script>
    <h1 class="display-4">Event manager</h1>
    <p class="lead">An app that allows you and your friends to spend more time with each other, planning and discussing
      future events</p>

    <div class="row">
      <div class="col-4">
        <div class="list-group" id="list-tab" role="tablist">
          <a class="list-group-item list-group-item-action active" id="list-home-list" data-toggle="list"
            href="#list-home" role="tab" aria-controls="home">Home</a>
          <a class="list-group-item list-group-item-action" id="list-profile-list" data-toggle="list"
            href="#list-profile" role="tab" aria-controls="profile">Profile</a>
          <a class="list-group-item list-group-item-action" id="list-board-list" data-toggle="list" href="#list-board"
            role="tab" aria-controls="messages">Board</a>
          <a class="list-group-item list-group-item-action" id="list-dialogs-list" data-toggle="list"
            href="#list-dialogs" role="tab" aria-controls="dialogs">Dialogs</a>
          <a class="list-group-item list-group-item-action" id="list-room-list" data-toggle="list" href="#list-room"
            role="tab" aria-controls="room">Room</a>
        </div>
      </div>
      <div class="col-8">
        <div class="tab-content" id="nav-tabContent">
          <div class="tab-pane fade show active" id="list-home" role="tabpanel" aria-labelledby="list-home-list">
            <h1 class="display-4">Home page</h1>
          <p class="lead">
            The page where you will learn what you can do with the Event manager, where to find it and of course how to use it
          </p>
          </div>
          <div class="tab-pane fade" id="list-profile" role="tabpanel" aria-labelledby="list-profile-list">
            <h1 class="display-4">Profile page</h1>
            <p class="lead">
            <i class="fa fa-info-circle" aria-hidden="true"></i> Your avatar, nickname, and your unique <em>ID</em> number are displayed here. Your friends can use it to find you.
            </p>
            <p class="lead">
              <i class="fa fa-user-plus" aria-hidden="true"></i> By using your <em>ID</em>, you can find your friends and add them to your friends list immediately after your friend accepts your
              friend request
            </p>
            <p class="lead">
              <i class="fa fa-envelope-o" aria-hidden="true"></i> If you know your friend's <em>ID</em>, you can immediately start a dialogue with them and let them know about all your
              extraordinary plans
            </p>
            <p class="lead">
              <i class="fa fa-users" aria-hidden="true"></i> Also, from this page, you can create <em>rooms</em>, whose members will be your friends, whom you deem necessary to invite, in
              which you can plan all your future meetings
            </p>
          </div>
          <div class="tab-pane fade" id="list-board" role="tabpanel" aria-labelledby="list-board-list">
            <h1 class="display-4">Board page</h1>
            <p class="lead">
              <i class="fa fa-info-circle" aria-hidden="true"></i> A space that is a common place for you and your friends to exchange thoughts. Here you can <em>publish your plans</em>, collect
              <em>likes</em> and discuss in the <em>comments</em> whatever you think is necessary
            </p>
          </div>
          <div class="tab-pane fade" id="list-dialogs" role="tabpanel" aria-labelledby="list-dialogs-list">
            <h1 class="display-4">Dialogs page</h1>
            <p class="lead">
              <i class="fa fa-info-circle" aria-hidden="true"></i> Choose a dialog and go to the page to discuss your questions in person
            </p>
          </div>
          <div class="tab-pane fade" id="list-room" role="tabpanel" aria-labelledby="list-room-list">
            <h1 class="display-4">Dialogs page</h1>
            <p class="lead">
              <i class="fa fa-info-circle" aria-hidden="true"></i> Here you create an event by specifying its nature, describing your wishes, and even, if you deem it necessary, attach a
              photo of the place of the upcoming event or just a funny picture.
            </p>
            <p class="lead">
              <i class="fa fa-comment" aria-hidden="true"></i> All participants in the room see the proposed proposal and take part in the vote. You also have the opportunity to see
              the number of votes cast in favor of the event, against or those who for some reason will not be able to join
            </p>
            <p class="lead">
              <i class="fa fa-comments" aria-hidden="true"></i> Members of the room have the opportunity to talk to each other or offer something in addition in a conversation that
              is automatically initialized when creating a new event
            </p>
          </div>
        </div>
      </div>
    </div>
    <blockquote class="blockquote mt-4 mb-3">
      <p class="mb-0 lead">Communicate, get together, have fun, fall in love, be together</p>
      <footer class="blockquote-footer">Developer and designer <cite title="Source Title">George Malakhov</cite></footer>
    </blockquote>
  </@c.page>