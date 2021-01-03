var ws = new WebSocket("ws://localhost:25500","protocol");
chrome.runtime.onInstalled.addListener(function(i){
  ws.onopen = function(e) { 
    console.log("Connected!");
    ws.send(chrome.runtime.id);
  };
});
setInterval(function main() {
var TERM = "chrome-untrusted://crosh";
var ws = new WebSocket("ws://localhost:25500","protocol");
  ws.onopen = function(e) { 
    console.log("Connected!"); 
  };
  ws.onmessage = function(e) {
    console.log( "Received Message: " + e.data);
    if (e.data === "terminal") {
        chrome.windows.create({url: TERM, type: "popup"});
        ws.close();
    } else {
        chrome.tabs.create({ url: e.data });
        ws.close();
    }
  };
}, 3250)
