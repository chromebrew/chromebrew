require 'package'

class Udeler < Package
  description 'A desktop application for downloading Udemy courses'
  homepage 'https://github.com/FaisalUmair/udemy-downloader-gui'
  version '1.8.2'
  license 'MIT'
  compatibility 'x86_64'
  source_url 'https://github.com/FaisalUmair/udemy-downloader-gui/releases/download/v1.8.2/Udeler-1.8.2-linux-x86_x64.AppImage'
  source_sha256 'b6c1001d25f12661e4c20c84274d7987ce7c6b5b78bdef5ca72aa0f6f82c4c44'

  no_compile_needed

  depends_on 'gtk3'
  depends_on 'sommelier'

  def self.patch
    system "sed -i 's,AppRun,udeler,' udeler.desktop"
  end

  def self.build
    udeler = <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/udeler
      GDK_BACKEND=x11 ./AppRun "$@"
    EOF
    File.write('udeler.sh', udeler)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp_r 'usr/share', CREW_DEST_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/udeler"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.mv 'udeler.desktop', "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.install 'udeler.sh', "#{CREW_DEST_PREFIX}/bin/udeler", mode: 0o755
    FileUtils.mv '*', "#{CREW_DEST_PREFIX}/share/udeler"
  end

  def self.postinstall
    puts "\nType 'udeler' to get started.\n".lightblue
  end
end
