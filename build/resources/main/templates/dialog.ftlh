<div id="Chat_Mess">
  <#import "parts/common.ftlh" as c>
    <@c.page>

      <div class="container mb-4">
        <div id="update_pls">
          <#if dialogSize==0>
            No messages yet
            <#else>
              <#list dialogMessList as dialogMes>
                <div class="row">
                  <div class="col-sm">
                    <#if dialogMes.getFromId()==target>
                      <div class="shadow p-3 mb-5 bg-white rounded">
                        <p class="lead">
                          ${dialogMes.getText()}
                        </p>
                        <small class="form-text text-muted">${dialogMes.getDate()}</small>
                      </div>
                    </#if>
                  </div>
                  <div class="col-sm">

                  </div>
                  <div class="col-sm">
                    <#if dialogMes.getFromId()==user>
                      <div class="shadow p-3 mb-5 bg-white rounded">
                        <p class="lead" align="right">
                          ${dialogMes.getText()}
                        </p>
                        <small class="form-text text-muted" align="right">${dialogMes.getDate()}</small>
                      </div>
                    </#if>
                  </div>
                </div>
              </#list>
          </#if>

        </div>
        <form method="post" id="sendMsg" class="cls_sendMsg">
          <div class="form-group">
            <label for="exampleFormControlTextarea1">Message</label>
            <textarea class="form-control" id="exampleFormControlTextarea1" rows="3" name="MessageText"
              class="cls_MsgText"></textarea>
          </div>
          <input type="hidden" name="_csrf" value="${_csrf.token}" class="cls__csrfMsg" />
          <div class="form-group">
            <button type="submit" class="btn btn-primary ml-2" id="try_empty">Send</button>
          </div>
        </form>

      </div>
</div>
<script type="text/javascript">
  window.scrollTo(0, document.body.scrollHeight);
</script>
<script type="text/javascript" src="//web-ptica.ru/VRV-files/jquery-2.1.3.min.js"></script>
<script type="text/javascript" src="//web-ptica.ru/VRV-files/knopkavverh/3.js"></script>
<script type='text/javascript'>
  var xmlDocument;

  setInterval(function refresh() {
    if ((window.innerHeight + window.pageYOffset) >= document.body.offsetHeight) {
      var XMLHttpRequestObject = false;
      if (window.XMLHttpRequest)
        XMLHttpRequestObject = new XMLHttpRequest();
      else if (window.ActiveXobject)
        XMLHttpRequestObject = new ActiveXObject("Microsoft.XMLHTTP");

      if (XMLHttpRequestObject) {
        XMLHttpRequestObject.open('GET', "/dialog/${dialog.id}/${dialog.getFirstUser().getId()}/${dialog.getSecondUser().getId()}", true);
        XMLHttpRequestObject.responseType = 'document';
        XMLHttpRequestObject.onreadystatechange = function () {
          if (XMLHttpRequestObject.readyState == 4 && XMLHttpRequestObject.status == 200) {
            xmlDocument = XMLHttpRequestObject.responseXML;
            document.getElementById('update_pls').innerHTML = xmlDocument.getElementById('update_pls').innerHTML;
            console.log("Update");
            window.scrollTo(0, document.body.scrollHeight);
          }
        }
        XMLHttpRequestObject.send(null);
      }
    }
  }, 500);
</script>
<script type='text/javascript'>
  var xmlDocument;
  var formMsg = document.getElementById('sendMsg');

  formMsg.onsubmit = function refresh(event) {

    var clsMsg = document.getElementById('exampleFormControlTextarea1');
    var valclsMsg = clsMsg.value;

    event.preventDefault();
    var XMLHttpRequestObject = false;
    if (window.XMLHttpRequest)
      XMLHttpRequestObject = new XMLHttpRequest();
    else if (window.ActiveXobject)
      XMLHttpRequestObject = new ActiveXObject("Microsoft.XMLHTTP");

    if (XMLHttpRequestObject) {
      XMLHttpRequestObject.open('POST', "/dialog/${dialog.id}/${dialog.getFirstUser().getId()}/${dialog.getSecondUser().getId()}", true);
      XMLHttpRequestObject.setRequestHeader('X-CSRF-Token', document.querySelector('.cls__csrfMsg').value);
      XMLHttpRequestObject.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
      XMLHttpRequestObject.responseType = 'document';
      XMLHttpRequestObject.onreadystatechange = function () {
        if (XMLHttpRequestObject.readyState == 4 && XMLHttpRequestObject.status == 200) {
          xmlDocument = XMLHttpRequestObject.responseXML;
          document.getElementById('update_pls').innerHTML = xmlDocument.getElementById('update_pls').innerHTML;
          console.log("send msg");
          window.scrollTo(0, document.body.scrollHeight);
        }
      }
      XMLHttpRequestObject.send("MessageText=" + valclsMsg);
    }
    clsMsg.value = "";
  };
</script>
</@c.page>