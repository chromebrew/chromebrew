require 'package'

class Ngrok < Package
  description 'ngrok exposes local servers behind NATs and firewalls to the public internet over secure tunnels.'
  homepage 'https://ngrok.com/'
  version '3.0.7-1'
  license 'Copyright (c) 2015 by Alan Shreve' # Source code not available
  compatibility 'all'
  source_url({
    aarch64: 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm.tgz',
     armv7l: 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm.tgz',
       i686: 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-386.tgz',
     x86_64: 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz'
  })
  source_sha256({
    aarch64: 'bfba9930dacd2243d7b188bd2457264253a037847c72c64849becc2ead7fc009',
     armv7l: 'bfba9930dacd2243d7b188bd2457264253a037847c72c64849becc2ead7fc009',
       i686: '28ae951575a8bb716261fe5f08f9f34952792b87d4c232b819e7d39500eb7089',
     x86_64: 'cbb3cd2f152c516c22d616cfcfdbadb6b42f6a662cd6e44f3c2a4556f284796f'
  })

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'ngrok', "#{CREW_DEST_PREFIX}/bin/ngrok", mode: 0o755
  end
end
