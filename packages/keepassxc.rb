require 'package'

class Keepassxc < Package
  description 'KeePass Cross-Platform Community Edition, the free, open source, light-weight and easy-to-use password manager.'
  homepage 'https://keepassxc.org/'
  version '2.7.6'
  license 'GPL-2 or GPL-3'
  compatibility 'x86_64'
  source_url 'https://github.com/keepassxreboot/keepassxc/releases/download/2.7.6/KeePassXC-2.7.6-x86_64.AppImage'
  source_sha256 'f32f7e7ab4bca789b24bd6a420c1d87dff40982646abef58fca481a7c56ace48'

  no_compile_needed

  depends_on 'sommelier'

  def self.build
    keepass = <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/keepassxc
      ./AppRun "$@"
    EOF
    File.write('keepassxc.sh', keepass)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/keepassxc"
    FileUtils.install 'keepassxc.sh', "#{CREW_DEST_PREFIX}/bin/keepassxc", mode: 0o755
    FileUtils.mv Dir.glob('*'), "#{CREW_DEST_PREFIX}/share/keepassxc"
  end

  def self.postinstall
    puts "\nType 'keepassxc' to get started.\n".lightblue
  end
end
