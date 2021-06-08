require 'package'

class Fd < Package
  description "A simple, fast and user-friendly alternative to 'find'"
  homepage 'https://github.com/sharkdp/fd'
  version '8.2.1'
  license 'Apache License Version 2.0'
  compatibility 'all'
  case ARCH
  when 'aarch64', 'armv7l'
    source_url 'https://github.com/sharkdp/fd/releases/download/v8.2.1/fd-v8.2.1-arm-unknown-linux-musleabihf.tar.gz'
    source_sha256 'b2e4d38f9beb20070d140643884c96c0f71089102b608eb3fe2ac7067de1dd3d'
  when 'i686'
    source_url 'https://github.com/sharkdp/fd/releases/download/v8.2.1/fd-v8.2.1-i686-unknown-linux-musl.tar.gz'
    source_sha256 '2632725f0a41f8a6012e6b451f978693ce24b6555ef52e33c161135a5ca90830'
  when 'x86_64'
    source_url 'https://github.com/sharkdp/fd/releases/download/v8.2.1/fd-v8.2.1-x86_64-unknown-linux-musl.tar.gz'
    source_sha256 'af511a1eb8c407397a52ebb7783ead06bd5c27f727ee0cb91e8adafd607ef9eb'
  end

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
