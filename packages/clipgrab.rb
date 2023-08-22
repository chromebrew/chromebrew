require 'package'

class Clipgrab < Package
  description 'A friendly downloader for YouTube and other sites'
  homepage 'https://clipgrab.org/'
  version '3.9.7'
  license 'GPL-3'
  compatibility 'x86_64'
  source_url 'https://download.clipgrab.org/ClipGrab-3.9.7-x86_64.AppImage'
  source_sha256 'acc14f71dceb9dcef7bf0a575180ecf80324d5435f7bb606bd0ba02308bf4efd'

  no_compile_needed

  depends_on 'ffmpeg'
  depends_on 'gtk3'

  def self.build
    @clipgrab = <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/clipgrab
      ./AppRun "$@"
    EOF
    File.write('clipgrab.sh', @clipgrab)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/clipgrab"
    FileUtils.install 'clipgrab.sh', "#{CREW_DEST_PREFIX}/bin/clipgrab", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/clipgrab"
  end

  def self.postinstall
    puts "\nType 'clipgrab' to get started.\n".lightblue
  end
end
