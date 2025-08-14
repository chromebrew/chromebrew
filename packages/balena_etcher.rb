require 'package'

class Balena_etcher < Package
  description 'Flash OS images to SD cards & USB drives, safely and easily.'
  homepage 'https://www.balena.io/etcher/'
  version '2.1.4'
  license 'Apache-2.0'
  compatibility 'x86_64'

  source_url 'https://github.com/balena-io/etcher/releases/download/v2.1.4/balena-etcher_2.1.4_amd64.deb'
  source_sha256 'c635213bb0724eb789bc036819cd1adb7d0693fd3bd26622811a8f7bd25e9252'

  no_compile_needed
  no_shrink

  depends_on 'libgconf'
  depends_on 'alsa_lib'
  depends_on 'atk'
  depends_on 'cairo'
  depends_on 'cups'
  depends_on 'dbus'
  depends_on 'expat'
  depends_on 'fontconfig'
  depends_on 'freetype'
  depends_on 'gcc'
  depends_on 'gdk_pixbuf'
  depends_on 'glib'
  depends_on 'gtk2'
  depends_on 'xzutils'
  depends_on 'libnotify'
  depends_on 'nss'
  depends_on 'pango'
  depends_on 'sommelier'

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.mv Dir['usr/*'], CREW_DEST_PREFIX
  end
end
