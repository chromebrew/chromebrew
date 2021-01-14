require 'em-websocket'
PWA_PREFIX = '/usr/local/lib/pwa'
CROSH = '/usr/bin/crosh'

EM.run {
     EM::WebSocket.run(:host => "0.0.0.0", :port => 25500) do |ws|
         ws.onopen { |handshake| }
         ws.onmessage { |message|
             system "#{message} &"
         }
end
         }
