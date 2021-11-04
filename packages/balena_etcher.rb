require 'package'

class Balena_etcher < Package
  description 'Flash OS images to SD cards & USB drives, safely and easily.'
  homepage 'https://www.balena.io/etcher/'
  @_ver = '1.6.0'
  version @_ver
  license 'Apache-2.0'
  compatibility 'x86_64, i686'
  case ARCH
  when 'x86_64'
    source_url "https://github.com/balena-io/etcher/releases/download/v#{@_ver}/balenaEtcher-#{@_ver}-x64.AppImage"
    source_sha256 '055af004e129009e040c654c0b0c13fd5d9b0fea8d7bbd206548935e508a8dbf'
  when 'i686'
    source_url "https://github.com/balena-io/etcher/releases/download/v#{@_ver}/balenaEtcher-#{@_ver}-ia32.AppImage"
    source_sha256 '04838bc4f451919fffc5528dae5df35b3c7af910b769401ddee751709f9407fa'
  end

  depends_on 'gtk2'
  depends_on 'freetype'
  depends_on 'cairo'
  depends_on 'xzutils'
  depends_on 'libnotify'
  depends_on 'nspr'
  depends_on 'libgconf'
  depends_on 'libxss'
  depends_on 'libcom_err'
  depends_on 'gsettings_desktop_schemas'
  depends_on 'xhost'
  depends_on 'sommelier'

  def self.build
    etcher = <<~EOF
      #!/bin/bash
      xhost si:localuser:root
      cd #{CREW_PREFIX}/share/balena-etcher
      sudo -E LD_LIBRARY_PATH=#{CREW_LIB_PREFIX} ./AppRun "$@"
    EOF
    IO.write('etcher.sh', etcher)
  end

  def self.install
    ENV['CREW_NOT_STRIP'] = '1'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/balena-etcher"
    FileUtils.install 'etcher.sh', "#{CREW_DEST_PREFIX}/bin/etcher", mode: 0755
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/balena-etcher"
  end

  def self.postinstall
    system "glib-compile-schemas #{CREW_PREFIX}/share/glib-2.0/schemas"
    puts
    puts "To get started, type 'etcher'.".lightblue
    puts
  end
end
