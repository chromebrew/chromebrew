require 'package'

class Fd < Package
  description "A simple, fast and user-friendly alternative to 'find'"
  homepage 'https://github.com/sharkdp/fd'
  version '8.3.0'
  license 'Apache License Version 2.0'
  compatibility 'all'
  source_url ({
    aarch64: 'https://github.com/sharkdp/fd/releases/download/v8.3.0/fd-v8.3.0-arm-unknown-linux-musleabihf.tar.gz',
     armv7l: 'https://github.com/sharkdp/fd/releases/download/v8.3.0/fd-v8.3.0-arm-unknown-linux-musleabihf.tar.gz',
       i686: 'https://github.com/sharkdp/fd/releases/download/v8.3.0/fd-v8.3.0-i686-unknown-linux-musl.tar.gz',
     x86_64: 'https://github.com/sharkdp/fd/releases/download/v8.3.0/fd-v8.3.0-x86_64-unknown-linux-musl.tar.gz',
  })
  source_sha256 ({
    aarch64: '14646b148e3cfbdaae667b32cf5eea48cf11e6ddc3dc0d845177c13053a316ff',
     armv7l: '14646b148e3cfbdaae667b32cf5eea48cf11e6ddc3dc0d845177c13053a316ff',
       i686: '279038bf1a9703934e3bddf2fa359af1445d3bbe4ab80e758ab5c58d96b0dd0e',
     x86_64: 'ff36894153f352a29ecf0efd97adcd3ac788053801726861c6db4bdec1aa8461',
  })

  def self.build
    File.write('fd.bash', "source #{CREW_PREFIX}/share/fd/autocomplete/fd.bash-completion")
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_MAN_PREFIX}/man1"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/fd"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc/bash.d"
    FileUtils.mv 'autocomplete', "#{CREW_DEST_PREFIX}/share/fd"
    FileUtils.install 'fd', "#{CREW_DEST_PREFIX}/bin/fd", mode: 0o755
    FileUtils.install 'fd.1', "#{CREW_DEST_MAN_PREFIX}/man1/fd.1", mode: 0o644
    FileUtils.install 'fd.bash', "#{CREW_DEST_PREFIX}/etc/bash.d/fd.bash", mode: 0o644
  end

  def self.postinstall
    puts "\nTo enable bash completion, execute the following:".lightblue
    puts "source ~/.bashrc".lightblue
    puts "\nType 'fd -h' to get started.\n".lightblue
  end
end
