require 'package'

class Keepassxc < Package
  description 'KeePass Cross-Platform Community Edition, the free, open source, light-weight and easy-to-use password manager.'
  homepage 'https://keepassxc.org/'
  version '2.6.6'
  license 'GPL-2 or GPL-3'
  compatibility 'x86_64'
  source_url 'https://github.com/keepassxreboot/keepassxc/releases/download/2.6.6/KeePassXC-2.6.6-x86_64.AppImage'
  source_sha256 '0928b4a748ab2a8c95931ffe1afc31c74ff47e3891ef8ff42b87acf014672f18'

  binary_url({})
  binary_sha256({})

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
    FileUtils.mv '*', "#{CREW_DEST_PREFIX}/share/keepassxc"
  end

  def self.postinstall
    puts "\nType 'keepassxc' to get started.\n".lightblue
  end
end
