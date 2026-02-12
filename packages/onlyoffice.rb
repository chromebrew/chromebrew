require 'package'

class Onlyoffice < Package
  description 'The most complete office suite'
  homepage 'https://www.onlyoffice.com/en/'
  version '9.2.1'
  license 'AGPL-3'
  compatibility 'x86_64'
  source_url "https://github.com/ONLYOFFICE/appimage-desktopeditors/releases/download/v#{version}/DesktopEditors-x86_64.AppImage"
  source_sha256 'f6bb6bf053d0f11306e7b9ae291a6d5cb079b20fd43ca32d53a1ff5e442eb0e9'

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
