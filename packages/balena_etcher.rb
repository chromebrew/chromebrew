require 'package'

class Balena_etcher < Package
  description 'Flash OS images to SD cards & USB drives, safely and easily.'
  homepage 'https://www.balena.io/etcher/'
  @_ver = '1.18.4'
  version @_ver
  license 'Apache-2.0'
  compatibility 'x86_64'

  source_url({
    x86_64: "https://github.com/balena-io/etcher/releases/download/v#{@_ver}/balenaEtcher-#{@_ver}-x64.AppImage"
  })

  source_sha256({
    x86_64: '94022b35d6935a133508d4e27674d26ae0a20a0fcee2deaae0aea765e6ff46de'
  })

  no_compile_needed

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

  def self.install
    FileUtils.mkdir_p %W[#{CREW_DEST_PREFIX}/bin #{CREW_DEST_PREFIX}/share/balena-etcher]
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/balena-etcher"
    FileUtils.ln_s "#{CREW_PREFIX}/share/balena-etcher/balena-etcher", "#{CREW_PREFIX}/bin/balena-etcher"
  end
end
