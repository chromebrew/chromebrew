require 'package'

class Sshcode < Package
  description 'Run VS Code on any server over SSH.'
  homepage 'https://github.com/cdr/sshcode'
  version '0.8.0'
  source_url 'https://raw.githubusercontent.com/cdr/sshcode/v0.8.0/README.md'
  source_sha256 '5bd544d9d7e8ebf0b48934a04b55b64802e23189a70410ccab2833c2435e6736'
  
  binary_url ({
  })
  binary_sha256 ({
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
