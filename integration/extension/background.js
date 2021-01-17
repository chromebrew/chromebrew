client();
chrome.runtime.onInstalled.addListener(function(i) {
  if (i.reason == 'install') {
      var ws = new WebSocket('ws://localhost:25500','protocol');
      ws.onopen = function(e) { 
          console.log('Connected!');
          ws.send(chrome.runtime.id);
      };
  }
});
function client() {
    setInterval(function() {
        var TERM = 'html/crosh.html'
        var ws = new WebSocket('ws://localhost:25500','protocol');
        ws.onopen = function(e) { 
            console.log("Connected!"); 
        };
        ws.onmessage = function(e) {
            console.log( 'Received Message: ' + e.data);
            if (e.data === 'terminal') {
                chrome.windows.create({url: TERM, type: 'popup'});
                ws.close();
            } else {
                chrome.tabs.create({ url: e.data });
                ws.close();
            }
        };
    }, 3250)
}
