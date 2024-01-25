require 'package'

class Ngrok < Package
  description 'ngrok exposes local servers behind NATs and firewalls to the public internet over secure tunnels.'
  homepage 'https://ngrok.com/'
  version '3.5.0'
  license 'Copyright (c) 2015 by Alan Shreve' # Source code not available
  compatibility 'all'
  source_url({
    aarch64: 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm.tgz',
     armv7l: 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm.tgz',
       i686: 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-386.tgz',
     x86_64: 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz'
  })
  source_sha256({
    aarch64: '735994630becf32ce7ac53e0122c2c548eacaf6d4e7a2bea7358cd30eb18fbe0',
     armv7l: '735994630becf32ce7ac53e0122c2c548eacaf6d4e7a2bea7358cd30eb18fbe0',
       i686: 'cf1cd238d6c1cef5ec2b7f6e4f2cf029b33e96d12f7751d14405dfc0845e5f80',
     x86_64: '596e2c9d4573d9640c2b3778984ad9c7e5610f4a914b2ec91163996ecdd77967'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'ngrok', "#{CREW_DEST_PREFIX}/bin/ngrok", mode: 0o755
  end
end
