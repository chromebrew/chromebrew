require 'package'

class Clipgrab < Package
  description 'A friendly downloader for YouTube and other sites'
  homepage 'https://clipgrab.org/'
  version '3.9.14'
  license 'GPL-3'
  compatibility 'x86_64'
  source_url "https://download.clipgrab.org/ClipGrab-#{version}-x86_64.AppImage"
  source_sha256 '4d6a0669b3da4992d22c85ad0ac80ed9095544b58acdbbda9b55ea795d106739'

  no_compile_needed

  depends_on 'ffmpeg'
  depends_on 'gtk3'

  def self.build
    File.write 'clipgrab.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/clipgrab
      ./AppRun "$@"
    EOF
    # Fixes ./AppRun: symbol lookup error: /usr/local/lib64/libQt5Core.so.5: undefined symbol: u_strToLower_73
    File.write 'clipgrab.env', <<~EOF
      LD_LIBRARY_PATH=#{CREW_PREFIX}/share/clipgrab/usr/lib:$LD_LIBRARY_PATH
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/clipgrab"
    FileUtils.install 'clipgrab.sh', "#{CREW_DEST_PREFIX}/bin/clipgrab", mode: 0o755
    FileUtils.install 'clipgrab.env', "#{CREW_DEST_PREFIX}/etc/env.d/clipgrab", mode: 0o644
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/clipgrab"
  end

  def self.postinstall
    ExitMessage.add "\nType 'clipgrab' to get started.\n"
  end
end
