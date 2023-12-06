require 'package'

class Ngrok < Package
  description 'ngrok exposes local servers behind NATs and firewalls to the public internet over secure tunnels.'
  homepage 'https://ngrok.com/'
  version '3.4.0'
  license 'Copyright (c) 2015 by Alan Shreve' # Source code not available
  compatibility 'all'
  source_url({
    aarch64: 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm.tgz',
     armv7l: 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm.tgz',
       i686: 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-386.tgz',
     x86_64: 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz'
  })
  source_sha256({
    aarch64: 'c16b2408a967917aa4d3daa8f14f923ded71c5004fdc27411c06a26413f4906a',
     armv7l: 'c16b2408a967917aa4d3daa8f14f923ded71c5004fdc27411c06a26413f4906a',
       i686: 'c817db35544f0572c73cf43eb1a7dd0ebde54d838d95a541e8732f04c9d0e8f8',
     x86_64: '8b6040b5e35dab4624e4206850d944db385386bde0c0f834077f7ce04cc10387'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'ngrok', "#{CREW_DEST_PREFIX}/bin/ngrok", mode: 0o755
  end
end
