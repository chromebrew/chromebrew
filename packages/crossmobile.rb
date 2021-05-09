require 'package'

class Crossmobile < Package
  description 'CrossMobile is a software tool to develop truly native multi-platform cross mobile applications for iOS, Android, Windows Mobile and Desktop'
  homepage 'https://crossmobile.org/'
  version '3.4.0'
  license 'LGPL-3.0'
  compatibility 'x86_64'
  source_url 'https://github.com/crossmob/CrossMobile/releases/download/v3.4.0/CrossMobile-3.4.0.x86_64.appimage'
  source_sha256 '295f65a8ef3d115061749370ec0a9eb68424e9b96d208acd91aa18818e3fa134'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'jdk8'
  depends_on 'sommelier'

  def self.build
    cross = <<~EOF
    #!/bin/bash
    cd #{CREW_PREFIX}/share/crossmobile
    ./AppRun "$@"
    EOF
    IO.write('crossmobile.sh', cross)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/crossmobile"
    FileUtils.install 'crossmobile.sh', "#{CREW_DEST_PREFIX}/bin/crossmobile", mode: 0755
    FileUtils.mv Dir.glob('*'), "#{CREW_DEST_PREFIX}/share/crossmobile"
  end

  def self.postinstall
    puts "\nType 'crossmobile' to get started.\n".lightblue
  end
end
