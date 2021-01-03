var ws = new WebSocket("ws://localhost:25500","dummyprotocol");
var TERM = "chrome-untrusted://crosh";
ws.onopen = function(e) { 
  console.log("Connected!"); 
  ws.send("terminal");
};
ws.onmessage = function(e) {
  console.log( "Received Message: " + e.data);
  if (e.data === "Ready") {
      window.close();
      chrome.windows.create({url: TERM, type: "popup"});
  }
 };
