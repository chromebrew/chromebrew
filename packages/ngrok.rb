require 'package'

class Ngrok < Package
  description 'ngrok exposes local servers behind NATs and firewalls to the public internet over secure tunnels.'
  homepage 'https://ngrok.com/'
  version '2.3.40'
  license 'Copyright (c) 2015 by Alan Shreve' # Source code not available
  compatibility 'all'
  source_url ({
    aarch64: 'https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-2.3.40-linux-arm.tgz',
     armv7l: 'https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-2.3.40-linux-arm.tgz',
       i686: 'https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-2.3.40-linux-386.tgz',
     x86_64: 'https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-2.3.40-linux-amd64.tar.gz',
  })
  source_sha256 ({
    aarch64: '8eea42d11453961c4c4bd74b5839f3c448f085c62e526eed16bc7db366591007',
     armv7l: '8eea42d11453961c4c4bd74b5839f3c448f085c62e526eed16bc7db366591007',
       i686: '24da165d1f204786cc006d9ef1b7e919c8ebc40c57d1d95e2d07c4d43a5083cd',
     x86_64: '6d095e7a411fc8bd9a82cfa32bb7d7bddebda510f629c76fa099cb4445815a43',
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'ngrok', "#{CREW_DEST_PREFIX}/bin/ngrok", mode: 0o755
  end
end
