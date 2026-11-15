require 'package'

class Espanso < Package
  description 'A Privacy-first, Cross-platform Text Expander written in Rust'
  homepage 'https://espanso.org'
  version '2.4.1'
  license 'GPL-3.0'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url "https://github.com/espanso/espanso/releases/download/v#{version}/Espanso-X11.AppImage"
  source_sha256 '58b1b9c270c2416f3c6cb9069dfbcfb882d82de3369cf675861102936fc5f540'

  no_compile_needed
  no_shrink
  print_source_bashrc

  depends_on 'gtk3'
  depends_on 'sommelier' => :logical

  def self.build
    File.write 'espanso.sh', <<~EOF
      #!/bin/bash
      cd #{CREW_PREFIX}/share/espanso
      GDK_BACKEND=x11 ./AppRun "$@"
    EOF
    File.write '10-espanso', <<~EOF
      #!/bin/bash
      espanso service start --unmanaged
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/espanso"
    FileUtils.install 'espanso.sh', "#{CREW_DEST_PREFIX}/bin/espanso", mode: 0o755
    FileUtils.install '10-espanso', "#{CREW_DEST_PREFIX}/etc/bash.d/10-espanso", mode: 0o644
    FileUtils.install './usr/share/applications/espanso.desktop', "#{CREW_DEST_PREFIX}/share/applications/espanso.desktop", mode: 0o644
    FileUtils.install './usr/share/icons/hicolor/160x160/apps/espanso.png', "#{CREW_DEST_PREFIX}/share/icons/hicolor/160x160/apps/espanso.png", mode: 0o644
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/espanso"
  end

  def self.postinstall
    ExitMessage.add "\nType 'espanso -h' to get started.\n"
  end
end
