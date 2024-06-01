require 'package'

class Clipgrab < Package
  description 'A friendly downloader for YouTube and other sites'
  homepage 'https://clipgrab.org/'
  version '3.9.10'
  license 'GPL-3'
  compatibility 'x86_64'
  source_url 'https://download.clipgrab.org/ClipGrab-3.9.10-x86_64.AppImage'
  source_sha256 'f53b007f953a533b6ec2c0ffb8370773f734e50bb8ba9ba767b088902ba0a7b1'

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
    puts "\nType 'clipgrab' to get started.\n".lightblue
  end
end
