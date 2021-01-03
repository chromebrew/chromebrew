var ws = new WebSocket("ws://localhost:25500","protocol");
ws.onopen = function(e) { 
  console.log("Connected!"); 
  ws.send("app");
  window.close();
};
