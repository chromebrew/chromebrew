require 'package'

class Sshcode < Package
  description 'Run VS Code on any server over SSH.'
  homepage 'https://github.com/cdr/sshcode'
  version '0.8.0'
  compatibility 'all'
  source_url 'https://raw.githubusercontent.com/cdr/sshcode/v0.8.0/README.md'
  source_sha256 '5bd544d9d7e8ebf0b48934a04b55b64802e23189a70410ccab2833c2435e6736'
  
  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/sshcode-0.8.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/sshcode-0.8.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/sshcode-0.8.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/sshcode-0.8.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1b78a1aa63a27ba45913de2cd1b647a3834fff5a8bc7f0be568d86095f9cae3f',
     armv7l: '1b78a1aa63a27ba45913de2cd1b647a3834fff5a8bc7f0be568d86095f9cae3f',
       i686: 'c6c78d1bf9fea74282f5b0af1a46e540fa5b6456409e5edf5fbc59917a547cf2',
     x86_64: 'cfa83667f73510c33fa4b39b1e0da17b5d43137290a00756361ae915807516c8',
  })

  depends_on 'go' => :build

  def self.install
    system "go get go.coder.com/sshcode"
    system "cd ~/go/src/go.coder.com/sshcode && git checkout tags/v0.8.0"
    system "go build -o #{CREW_DEST_PREFIX}/bin/sshcode go.coder.com/sshcode"
  end

  def self.postinstall
    # https://github.com/cdr/sshcode/pull/82
    puts 'To use sshcode you need to bind the webserver to 0.0.0.0:<port>'.lightgreen
    puts 'For example: sshcode --skipsync --bind 0.0.0.0:8080 [remote-ssh-ip]'.lightgreen
    puts 'Syncing extensions does not work at this time.'.lightgreen
    puts
  end
end
