require 'package'

class Krita < Package
  description 'A generic image manipulation/painting application in the style of Photoshop or GIMP.'
  homepage 'https://krita.org/en'
  version '5.0.2'
  license 'GPL-3'
  compatibility 'x86_64'
  source_url 'https://download.kde.org/stable/krita/5.0.2/krita-5.0.2-x86_64.appimage'
  source_sha256 '139e621ec3a4ec1918e6046bdd7be4c0b392cdf2571ca83a065a3e2f00f585e8'

  no_compile_needed

  depends_on 'gtk3'
  depends_on 'sommelier'

  def self.build
    krita = <<~EOF
      #!/bin/bash
      SCALE=1
      RESOLUTION=$(xdpyinfo | awk '/dimensions:/ { print $2 }' | cut -d'x' -f1)
      [[ $RESOLUTION -gt 1500 && $RESOLUTION -lt 3000 ]] && SCALE=1.5
      [[ $RESOLUTION -ge 3000 && $RESOLUTION -lt 4500 ]] && SCALE=2
      [[ $RESOLUTION -ge 4500 && $RESOLUTION -lt 6000 ]] && SCALE=2.5
      [[ $RESOLUTION -ge 6000 ]] && SCALE=3
      export GDK_BACKEND=x11
      export QT_SCALE_FACTOR=$SCALE
      export PYTHONPATH=#{CREW_PREFIX}/share/krita/usr/lib/python3.8:$PYTHONPATH
      export LD_LIBRARY_PATH=#{CREW_PREFIX}/share/krita/usr/lib:$LD_LIBRARY_PATH
      cd #{CREW_PREFIX}/share/krita
      ./AppRun "$@"
    EOF
    File.write('krita.sh', krita)
  end

  def self.install
    conflicts_ok
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.cp_r 'usr/share', CREW_DEST_PREFIX
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/krita"
    FileUtils.install 'krita.sh', "#{CREW_DEST_PREFIX}/bin/krita", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/krita"
  end

  def self.postinstall
    puts "\nType 'krita' to get started.\n".lightblue
  end
end
