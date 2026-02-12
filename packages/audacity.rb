require 'package'

class Audacity < Package
  description "Audacity is the world's most popular audio editing and recording app"
  homepage 'https://www.audacityteam.org/'
  version '3.7.7'
  license 'GPL-3'
  compatibility 'x86_64'
  min_glibc '2.30'
  source_url "https://github.com/audacity/audacity/releases/download/Audacity-#{version}/audacity-linux-#{version}-x64-22.04.AppImage"
  source_sha256 '45c4445fb6670cc5fe40d31c7cea979724d2605bca53b554c32520acbf901ef0'

  depends_on 'gtk3'
  depends_on 'libthai'
  depends_on 'sommelier' => :logical

  no_shrink
  no_compile_needed

  def self.build
    File.write 'audacity.sh', <<~EOF
      #!/bin/bash
      export APPDIR=#{CREW_PREFIX}/share/audacity/usr
      export LD_LIBRARY_PATH="#{CREW_PREFIX}/share/audacity/lib:#{CREW_LIB_PREFIX}"
      cd $APPDIR
      GDK_BACKEND=x11 ./AppRun "$@"
    EOF
  end

  def self.install
    FileUtils.rm_rf 'usr/share/glib-2.0'
    FileUtils.mkdir_p CREW_DEST_PREFIX.to_s
    FileUtils.mv 'usr/share', CREW_DEST_PREFIX.to_s
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/audacity"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/applications"
    FileUtils.install 'audacity.sh', "#{CREW_DEST_PREFIX}/bin/audacity", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/audacity"
    %w[libatk-1.0.so.0 libatk-bridge-2.0.so.0 libcairo-gobject.so.2 libcairo.so.2 libgio-2.0.so.0 \
       libglib-2.0.so.0 libgmodule-2.0.so.0 libgobject-2.0.so.0 libgthread-2.0.so.0 libjack.so.0 \
       libpango-1.0.so.0 libpixman-1.so.0 libportaudio.so librsvg-2.so.2].each do |library|
      FileUtils.ln_sf "#{CREW_PREFIX}/share/audacity/fallback/#{library}/#{library}",
                      "#{CREW_DEST_PREFIX}/share/audacity/lib/#{library}"
    end
  end

  def self.postinstall
    ExitMessage.add "\nType 'audacity' to get started.\n"
  end
end
