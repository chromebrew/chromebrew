require 'package'

class Krita < Package
  description 'A generic image manipulation/painting application in the style of Photoshop or GIMP.'
  homepage 'https://krita.org/en'
  version '5.1.4'
  license 'GPL-3'
  compatibility 'x86_64'
  source_url 'https://download.kde.org/stable/krita/5.1.4/krita-5.1.4-x86_64.appimage'
  source_sha256 'f6678796cb98086b1e576aae4911e3d6b133cd0a4ec61a900ff5136a9f55917d'

  depends_on 'gtk3'
  depends_on 'gdk_base'
  depends_on 'sommelier'

  no_compile_needed
  print_reload_bashrc

  def self.build
    krita = <<~EOF
      #!/bin/bash
      export PYTHONHOME=#{CREW_PREFIX}/bin
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
    ExitMessage.add "\nType 'krita' to get started.\n".lightblue
  end
end
