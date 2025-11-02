# Depreciated upstream

require 'package'

class Sshcode < Package
  description 'Run VS Code on any server over SSH.'
  homepage 'https://github.com/coder/sshcode'
  version '0.10.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/coder/sshcode.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5a64b03d3fb8d76ca8d41992bbca8234cad3a93f492c5aaf100448e6646d1e61',
     armv7l: '5a64b03d3fb8d76ca8d41992bbca8234cad3a93f492c5aaf100448e6646d1e61',
       i686: '2c789847f199eb8a0c50c4326b55a3e06c1dc0a35bba221b4a346e2d787ea799',
     x86_64: '59a857b1a4cee939e2f8b4a7afbc2fdf03b68ba33225e6833a7e3c6d809c48ba'
  })

  depends_on 'glibc' # R
  depends_on 'go' => :build

  def self.install
    system "go build -o #{CREW_DEST_PREFIX}/bin/sshcode"
  end

  def self.postinstall
    # https://github.com/coder/sshcode/pull/82
    ExitMessage.add <<~EOM

      To use sshcode you need to bind the webserver to 0.0.0.0:<port>
      For example: sshcode --skipsync --bind 0.0.0.0:8080 [remote-ssh-ip]
      Syncing extensions does not work at this time.
    EOM
  end
end
