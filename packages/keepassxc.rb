require 'package'

class Keepassxc < Package
  description 'KeePass Cross-Platform Community Edition, the free, open source, light-weight and easy-to-use password manager.'
  homepage 'https://keepassxc.org/'
  version '2.6.4'
  license 'GPL-2 or GPL-3'
  compatibility 'x86_64'
  source_url 'https://github.com/keepassxreboot/keepassxc/releases/download/2.6.4/KeePassXC-2.6.4-x86_64.AppImage'
  source_sha256 '5f9657440eb0740ad65e7fc3c80524247a863315528705b8fb79df6755329483'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'sommelier'

  def self.build
    keepass = <<~EOF
    #!/bin/bash
    cd #{CREW_PREFIX}/share/keepassxc
    ./AppRun "$@"
    EOF
    IO.write('keepassxc.sh', keepass)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/keepassxc"
    FileUtils.install 'keepassxc.sh', "#{CREW_DEST_PREFIX}/bin/keepassxc", mode: 0755
    FileUtils.mv Dir.glob('*'), "#{CREW_DEST_PREFIX}/share/keepassxc"
  end

  def self.postinstall
    puts "\nType 'keepassxc' to get started.\n".lightblue
  end
end
