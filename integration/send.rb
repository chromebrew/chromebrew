require 'em-websocket'

EM.run {
     EM::WebSocket.run(:host => "0.0.0.0", :port => 25500) do |ws|
         ws.onopen { |handshake|
             ws.send ARGV[0].dup
             }
         ws.onclose { exit(0) }    
         end
    }
