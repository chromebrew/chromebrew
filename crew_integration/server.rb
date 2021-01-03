require 'em-websocket'
PWA_PREFIX = '/usr/local/lib/pwa'
CROSH = '/usr/bin/crosh'

EM.run {
     EM::WebSocket.run(:host => "0.0.0.0", :port => 25500) do |ws|
         ws.onopen { |handshake| }
         ws.onmessage { |message|
             case message
             when 'terminal'
                 system "sudo mount -io bind #{PWA_PREFIX}/crosh.sh #{CROSH}"
                 ws.send 'Ready'
             else
                 system message
             end
         }
end
         }
