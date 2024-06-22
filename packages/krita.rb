require 'package'

class Krita < Package
  description 'A generic image manipulation/painting application in the style of Photoshop or GIMP.'
  homepage 'https://krita.org/en'
  version '5.2.2'
  license 'GPL-3'
  compatibility 'x86_64'
  min_glibc '2.29'
  source_url "https://download.kde.org/stable/krita/#{version}/krita-#{version}-x86_64.appimage"
  source_sha256 'b69297bcbf916595c14e8585e2dc9fea35c992b416d721d3bdb5558de2405be0'

  depends_on 'gtk3'
  depends_on 'gdk_base'
  depends_on 'sommelier'

  no_compile_needed
  no_shrink

  def self.build
    krita = <<~EOF
      #!/bin/bash
      export PYTHONHOME=#{CREW_PREFIX}/bin
      export PYTHONPATH=#{CREW_PREFIX}/share/krita/usr/lib/python3.10:$PYTHONPATH
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
