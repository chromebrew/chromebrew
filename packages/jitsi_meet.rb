require 'package'

class Jitsi_meet < Package
  description 'Jitsi Meet video conferencing desktop application'
  homepage 'https://jitsi.org/jitsi-meet/'
  version '2025.10.0'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url "https://github.com/jitsi/jitsi-meet-electron/releases/download/v#{version}/jitsi-meet-x86_64.AppImage"
  source_sha256 '1bc259c4c099f6d9bf1d1decc846602b9acf956696d39f75d0a4eefb6ab0acb1'

  depends_on 'gtk3'
  depends_on 'sommelier' => :logical

  no_compile_needed
  no_shrink

  def self.patch
    system "sed -i 's,AppRun,jitsi,' jitsi-meet.desktop"
  end

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX.to_s
    FileUtils.mv 'usr/share', CREW_DEST_PREFIX.to_s
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/jitsi"
    FileUtils.mv 'usr/lib', "#{CREW_DEST_PREFIX}/share/jitsi"
    FileUtils.mv Dir['lib*.so*'], "#{CREW_DEST_PREFIX}/share/jitsi/lib"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.rm_rf 'usr'
    FileUtils.rm 'jitsi-meet.png'
    FileUtils.mv 'jitsi-meet.desktop', "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/jitsi"
    File.write 'jitsi.sh', <<~EOF
      #!/bin/bash
      LD_LIBRARY_PATH=#{CREW_PREFIX}/share/jitsi/lib:$LD_LIBRARY_PATH
      cd #{CREW_PREFIX}/share/jitsi
      GDK_BACKEND=x11 ./AppRun "$@"
    EOF
    FileUtils.install 'jitsi.sh', "#{CREW_DEST_PREFIX}/bin/jitsi", mode: 0o755
  end

  def self.postinstall
    ExitMessage.add "\nType 'jitsi' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/.config/Jitsi Meet")
  end
end
