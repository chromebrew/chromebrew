require 'package'

class Ngrok < Package
  description 'ngrok exposes local servers behind NATs and firewalls to the public internet over secure tunnels.'
  homepage 'https://ngrok.com/'
  version '3.1.0'
  license 'Copyright (c) 2015 by Alan Shreve' # Source code not available
  compatibility 'all'
  source_url({
    aarch64: 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm.tgz',
     armv7l: 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm.tgz',
       i686: 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-386.tgz',
     x86_64: 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz'
  })
  source_sha256({
    aarch64: 'e0bf8908b9952f98137082bfa5724a7f0f275a98adf86e782c8d6a08fc08c103',
     armv7l: 'e0bf8908b9952f98137082bfa5724a7f0f275a98adf86e782c8d6a08fc08c103',
       i686: '665975464823b4f0d7a4527b6d90b3be3d1116b5c70d0a1f3fc1bd6e5ab50adc',
     x86_64: '7386d7af1eb115a6e6bec4b98105f08a4c6edd42d85aae341e80a84be8f04637'
  })

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'ngrok', "#{CREW_DEST_PREFIX}/bin/ngrok", mode: 0o755
  end
end
