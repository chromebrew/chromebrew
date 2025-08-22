require 'package'

class Balena_etcher < Package
  description 'Flash OS images to SD cards & USB drives, safely and easily.'
  homepage 'https://etcher.balena.io'
  version '2.1.3'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url "https://github.com/balena-io/etcher/releases/download/v#{version}/balenaEtcher-#{version}-x64.AppImage"
  source_sha256 'd17976ac200b0379b1668b24a51ebf69124855d7dbf28f1333c446459b94147f'

  depends_on 'gtk3'
  depends_on 'freetype'
  depends_on 'cairo'
  depends_on 'xzutils'
  depends_on 'libnotify'
  depends_on 'nss'
  depends_on 'libgconf'
  depends_on 'libxss'
  depends_on 'libcom_err'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'xhost'
  depends_on 'sommelier'

  gnome
  no_compile_needed
  no_shrink

  def self.build
    File.write 'etcher.sh', <<~EOF
      #!/bin/bash
      xhost si:localuser:root
      cd #{CREW_PREFIX}/share/balena-etcher
      sudo -E LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} ./AppRun "$@"
    EOF
  end

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/bin #{CREW_DEST_PREFIX}/share/balena-etcher]
    FileUtils.install 'etcher.sh', "#{CREW_DEST_PREFIX}/bin/etcher", mode: 0o755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/balena-etcher"
  end

  def self.postinstall
    ExitMessage.add "\nType 'etcher' to get started.\n"
  end
end
