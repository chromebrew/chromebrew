require 'buildsystems/meson'

class Modemmanager < Meson
  description 'ModemManager is a DBus-activated daemon which controls mobile broadband (2G/3G/4G) devices and connections.'
  homepage 'https://www.freedesktop.org/wiki/Software/ModemManager/'
  version '1.24.2'
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://gitlab.freedesktop.org/mobile-broadband/ModemManager.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '94f3c8bbd650ef793c33b776ddf0595d5802dc47a351145d4f9c05b1fa26d215',
     armv7l: '94f3c8bbd650ef793c33b776ddf0595d5802dc47a351145d4f9c05b1fa26d215',
     x86_64: 'e7b396102ea6fdeda439dcae3f55cb60598e512f2d276d1699e17187c7dd2e10'
  })

  depends_on 'dbus' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libgudev' => :executable
  depends_on 'libmbim' => :library
  depends_on 'libqmi' => :library
  depends_on 'libqrtr_glib' => :executable
  depends_on 'polkit' => :executable

  meson_options '-Dsystemdsystemunitdir=no -Dsystemd_suspend_resume=false -Dsystemd_journal=false'
end
