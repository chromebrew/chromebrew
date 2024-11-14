require 'package'

class Onlyoffice < Package
  description 'The most complete office suite'
  homepage 'https://www.onlyoffice.com/en/'
  version '8.0.1'
  license 'AGPL-3'
  compatibility 'x86_64'
  source_url "https://github.com/ONLYOFFICE/appimage-desktopeditors/releases/download/v#{version}/DesktopEditors-x86_64.AppImage"
  source_sha256 '85e9e23363fe5076cebffe5569a1bc0f51eb80bd424e5085d19ec84e936c33f2'

  depends_on 'gtk3'
  depends_on 'gdk_base'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'sommelier'

  gnome
  no_compile_needed
  no_shrink

  def self.build
    File.write 'onlyoffice', <<~EOF
      #!/bin/bash
      export LD_LIBRARY_PATH=#{CREW_PREFIX}/share/onlyoffice/usr/lib:$LD_LIBRARY_PATH
      cd #{CREW_PREFIX}/share/onlyoffice
      ./AppRun "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/onlyoffice"
    FileUtils.install 'onlyoffice', "#{CREW_DEST_PREFIX}/bin/onlyoffice", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/onlyoffice"
  end

  def self.postinstall
    ExitMessage.add "\nType 'onlyoffice' to get started.\n".lightblue
  end
end
