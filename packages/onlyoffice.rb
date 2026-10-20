require 'package'

class Onlyoffice < Package
  description 'The most complete office suite'
  homepage 'https://www.onlyoffice.com/en/'
  version '10.0.0'
  license 'AGPL-3'
  compatibility 'x86_64'
  source_url "https://github.com/ONLYOFFICE/appimage-desktopeditors/releases/download/v#{version}/DesktopEditors-x86_64.AppImage"
  source_sha256 '3e4668d44f6881d1d8873b38ea9c9fd81b9c77132facdb735bfebfe960edb745'

  depends_on 'gtk3' # R
  depends_on 'gdk_base' # R
  depends_on 'gsettings_desktop_schemas' # R
  depends_on 'libnotify' # R
  depends_on 'sommelier' => :logical

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
    ExitMessage.add "\nType 'onlyoffice' to get started.\n"
  end
end
