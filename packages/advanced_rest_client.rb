require 'package'

class Advanced_rest_client < Package
  description 'Advanced REST Client - Desktop application'
  homepage 'https://github.com/advanced-rest-client/arc-electron'
  version '17.0.9'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url 'https://github.com/advanced-rest-client/arc-electron/releases/download/v17.0.9/arc-linux-17.0.9-x86_64.AppImage'
  source_sha256 '0461eb86ffad7ee733964a527c1b85e06154454f655631d7bef5ea5b111577d5'

  depends_on 'gtk3'
  depends_on 'sommelier'

  no_shrink

  def self.build
    File.write 'arc.sh', <<~EOF
      #!/bin/bash
      export APPDIR=#{CREW_PREFIX}/share/advanced-rest-client
      cd $APPDIR
      GDK_BACKEND=x11 ./AppRun --no-sandbox "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp_r 'usr/share', CREW_DEST_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/advanced-rest-client"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.mv 'advanced-rest-client.desktop', "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.install 'arc.sh', "#{CREW_DEST_PREFIX}/bin/arc", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/advanced-rest-client"
  end

  def self.postinstall
    ExitMessage.add "\nType 'arc' to get started.\n".lightblue
  end
end
