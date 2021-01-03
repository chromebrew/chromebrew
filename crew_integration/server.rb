require 'em-websocket'
require 'fileutils'
PWA_PREFIX = '/usr/local/lib/pwa'
CROSH_PREFIX = '/usr/share/crosh'

EM.run {
     EM::WebSocket.run(:host => "0.0.0.0", :port => 25500) do |ws|
         ws.onopen { |handshake| }
         ws.onmessage { |message|
             case message
             when 'terminal'
                 FileUtils.mkdir_p PWA_PREFIX
                 system "sudo mount -io bind #{PWA_PREFIX}/50-crosh.sh #{CROSH_PREFIX}/dev.d/50-crosh.sh"
                 ws.send 'Ready'
             else
                 system message
             end
         }
end
         }
