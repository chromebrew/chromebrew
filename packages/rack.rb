require 'package'

class Rack < Package
  description 'The Rackspace Command Line Interface (rack CLI) is a unified tool for managing your Rackspace services.'
  homepage 'https://github.com/rackspace/rack'
  version '1.2'
  compatibility 'all'
  source_url 'https://raw.githubusercontent.com/rackspace/rack/1.2/README.md'
  source_sha256 '2681ad55f204718cb8bcc8cbe0b2da66897f3310cb78576ae248a252a9b7f544'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/rack-1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/rack-1.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/rack-1.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/rack-1.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f260e4c1d348686568f7848e9dc5f70a156e38552efe2322ab10afe349614e8c',
     armv7l: 'f260e4c1d348686568f7848e9dc5f70a156e38552efe2322ab10afe349614e8c',
       i686: 'b7e25830c451727f4693ffb97eeebd35e1091a7b5fad2ca365ea768890b66594',
     x86_64: '7a80c8cd2dbb9591844f24f06d7ec5d7ee3e07687ef4bc0d564223a7d7d6a609',
  })

  depends_on 'go' => :build

  def self.install
    system "go get github.com/rackspace/rack"
    system "cd ~/go/src/github.com/rackspace/rack && git checkout 1.2"
    system "install -Dm644 ~/go/src/github.com/rackspace/rack/setup/commandcompletion_bash.sh #{CREW_DEST_PREFIX}/share/rack/commandcompletion_bash.sh"
    system "go build -o #{CREW_DEST_PREFIX}/bin/rack github.com/rackspace/rack"
  end

  def self.postinstall
    puts
    puts "To add command completion in bash, execute the following:".lightblue
    puts "echo 'if [ -f #{CREW_PREFIX}/share/rack/commandcompletion_bash.sh ]; then' >> ~/.bashrc".lightblue
    puts "echo '  source #{CREW_PREFIX}/share/rack/commandcompletion_bash.sh' >> ~/.bashrc".lightblue
    puts "echo 'fi' >> ~/.bashrc".lightblue
    puts "source ~/.bashrc".lightblue
    puts
  end
end
