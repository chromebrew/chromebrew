require 'package'

class Mcfly < Package
  description 'fly through your shell history'
  homepage 'https://github.com/cantino/mcfly'
  version '0.9.3'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/cantino/mcfly/releases/download/v#{version}/mcfly-v#{version}-armv7-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://github.com/cantino/mcfly/releases/download/v#{version}/mcfly-v#{version}-armv7-unknown-linux-gnueabihf.tar.gz",
       i686: "https://github.com/cantino/mcfly/releases/download/v#{version}/mcfly-v#{version}-i686-unknown-linux-musl.tar.gz",
     x86_64: "https://github.com/cantino/mcfly/releases/download/v#{version}/mcfly-v#{version}-x86_64-unknown-linux-musl.tar.gz"
  })
  source_sha256({
    aarch64: 'f8b960a5c9b7634637b40cd6823458d8e39eb3c0bfecaa540dd7a4d446f01771',
     armv7l: 'f8b960a5c9b7634637b40cd6823458d8e39eb3c0bfecaa540dd7a4d446f01771',
       i686: 'd3a1f513e5dead8400a1bd431fb1b579ad7ace8bcd6a27610eb4d2fa2982afc1',
     x86_64: 'be0d3c1e0253189a5d834767231c2a4d206f077f4184699ac7069482ed9c6453'
  })

  no_compile_needed
  no_shrink
  print_source_bashrc

  def self.build
    File.write '10-mcfly', <<~EOF
      #!/bin/bash
      eval "$(mcfly init bash)"
    EOF
  end

  def self.install
    FileUtils.install '10-mcfly', "#{CREW_DEST_PREFIX}/etc/bash.d/10-mcfly", mode: 0o644
    FileUtils.install 'mcfly', "#{CREW_DEST_PREFIX}/bin/mcfly", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'mcfly' to get started.\n"
  end
end
