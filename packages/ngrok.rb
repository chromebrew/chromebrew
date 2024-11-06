require 'package'

class Ngrok < Package
  description 'ngrok exposes local servers behind NATs and firewalls to the public internet over secure tunnels.'
  homepage 'https://ngrok.com/'
  version '3.12.0'
  license 'Copyright (c) 2015 by Alan Shreve' # Source code not available
  compatibility 'all'
  source_url({
    aarch64: 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm.tgz',
     armv7l: 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm.tgz',
       i686: 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-386.tgz',
     x86_64: 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz'
  })
  source_sha256({
    aarch64: '6742cdc484c9ab3a8aeccf06dff402d848eab710475506c3575190945f1f0e6d',
     armv7l: '6742cdc484c9ab3a8aeccf06dff402d848eab710475506c3575190945f1f0e6d',
       i686: 'fd6e49482743e653b4b617418434cf00d668e234d888701d17458e71d7e8721f',
     x86_64: 'd6ebcfd61f46b9df43878fde55bcd0c5b3f556f2d2456d7af56b995726039b56'
  })

  no_compile_needed
  no_shrink

  def self.install
    FileUtils.install 'ngrok', "#{CREW_DEST_PREFIX}/bin/ngrok", mode: 0o755
  end
end
