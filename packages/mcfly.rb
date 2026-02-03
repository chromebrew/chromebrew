require 'package'

class Mcfly < Package
  description 'fly through your shell history'
  homepage 'https://github.com/cantino/mcfly'
  version '0.9.4'
  license 'MIT'
  compatibility 'all'
  source_url({
    aarch64: "https://github.com/cantino/mcfly/releases/download/v#{version}/mcfly-v#{version}-armv7-unknown-linux-gnueabihf.tar.gz",
     armv7l: "https://github.com/cantino/mcfly/releases/download/v#{version}/mcfly-v#{version}-armv7-unknown-linux-gnueabihf.tar.gz",
       i686: "https://github.com/cantino/mcfly/releases/download/v#{version}/mcfly-v#{version}-i686-unknown-linux-musl.tar.gz",
     x86_64: "https://github.com/cantino/mcfly/releases/download/v#{version}/mcfly-v#{version}-x86_64-unknown-linux-musl.tar.gz"
  })
  source_sha256({
    aarch64: '10a8673e50394c6164777a85e26313e05be8cb84052c7083c3b8fe78e4bd63f4',
     armv7l: '10a8673e50394c6164777a85e26313e05be8cb84052c7083c3b8fe78e4bd63f4',
       i686: 'abcb88eb876e3b13e63fd3526513c0bd0fd494fe60f5666713ee92b7eaed3728',
     x86_64: '72d2c6fdaa111ac96c2cf725fc40e313e2856643482be58608911a09440313f1'
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
