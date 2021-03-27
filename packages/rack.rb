require 'package'

class Rack < Package
  description 'The Rackspace Command Line Interface (rack CLI) is a unified tool for managing your Rackspace services.'
  homepage 'https://github.com/rackspace/rack'
  version '1.2'
  license 'MIT'
  compatibility 'all'
  source_url 'https://raw.githubusercontent.com/rackspace/rack/1.2/README.md'
  source_sha256 '2681ad55f204718cb8bcc8cbe0b2da66897f3310cb78576ae248a252a9b7f544'

  depends_on 'go' => :build

  def self.install
    system "go get github.com/rackspace/rack"
    system "cd ~/go/src/github.com/rackspace/rack && git checkout 1.2"
    system "install -Dm644 ~/go/src/github.com/rackspace/rack/setup/commandcompletion_bash.sh #{CREW_DEST_PREFIX}/share/rack/commandcompletion_bash.sh"
    system "go build -o #{CREW_DEST_PREFIX}/bin/rack github.com/rackspace/rack"

    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d/"
    @env = <<~EOF
      # rack bash completion
      source #{CREW_PREFIX}/share/rack/commandcompletion_bash.sh
    EOF
    IO.write("#{CREW_DEST_PREFIX}/etc/bash.d/rack", @env)
  end
end
