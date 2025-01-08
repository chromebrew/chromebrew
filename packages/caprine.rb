require 'package'

class Caprine < Package
  description 'An elegant Facebook Messenger desktop app'
  homepage 'https://sindresorhus.com/caprine/'
  version '2.60.3'
  license 'MIT'
  compatibility 'x86_64'
  source_url "https://github.com/sindresorhus/caprine/releases/download/v#{version}/Caprine-#{version}.AppImage"
  source_sha256 '3fc8f57fcff84638d81679846ee9241091f71e914be7657787218f96985a73ce'

  depends_on 'gtk3'
  depends_on 'sommelier'

  no_compile_needed
  no_shrink

  def self.build
    File.write 'caprine.sh', <<~EOF
      #!/bin/bash
      export APPDIR=#{CREW_PREFIX}/share/caprine
      cd $APPDIR
      GDK_BACKEND=x11 ./AppRun --no-sandbox "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp_r 'usr/share', CREW_DEST_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/caprine"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.mv 'caprine.desktop', "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.install 'caprine.sh', "#{CREW_DEST_PREFIX}/bin/caprine", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/caprine"
  end

  def self.postinstall
    ExitMessage.add "\nType 'caprine' to get started.\n"
  end
end
