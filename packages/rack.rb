require 'package'

class Rack < Package
  description 'The Rackspace Command Line Interface (rack CLI) is a unified tool for managing your Rackspace services.'
  homepage 'https://github.com/rackspace/rack'
  version '1.2'
  source_url 'https://raw.githubusercontent.com/rackspace/rack/1.2/README.md'
  source_sha256 '2681ad55f204718cb8bcc8cbe0b2da66897f3310cb78576ae248a252a9b7f544'

  binary_url ({
  })
  binary_sha256 ({
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
