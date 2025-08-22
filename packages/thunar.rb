require 'buildsystems/autotools'
require 'convenience_functions'

class Thunar < Autotools
  description 'Thunar File Manager'
  homepage 'https://docs.xfce.org/xfce/thunar/Start'
  version '4.20.4'
  license 'GPL-2+ and LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://archive.xfce.org/src/xfce/thunar/#{version.rpartition('.')[0]}/thunar-#{version}.tar.bz2"
  source_sha256 '27731a76f3aecf3752b1ca35afad89e264c52244f70083d933507dd4a17548b0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a320306ea82a355c3a9170b4ba4904174f6f6688e1a0a3977c14b729c8a9d0b6',
     armv7l: 'a320306ea82a355c3a9170b4ba4904174f6f6688e1a0a3977c14b729c8a9d0b6',
     x86_64: '1d41b96fadf908ad2985c331f8a498deaca1b362eee2097b654295c0dcbf7a3e'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'exo' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'libexif' # R
  depends_on 'libgudev' # R
  depends_on 'libice' # R
  depends_on 'libnotify' # R
  depends_on 'libsm' # R
  depends_on 'libx11' # R
  depends_on 'libxfce4ui' # R
  depends_on 'libxfce4util' # R
  depends_on 'pango' # R
  depends_on 'pcre2' # R
  depends_on 'xfce4_panel' # R
  depends_on 'xfconf' # R
  depends_on 'zlib' # R

  def self.prebuild
    ConvenienceFunctions.libtoolize('glib-2.0', 'glib')
    ConvenienceFunctions.libtoolize('harfbuzz')
  end

  autotools_configure_options '--enable-gio-unix \
    --enable-gudev \
    --enable-exif \
    --enable-pcre \
    --disable-static \
    --enable-notifications'

  run_tests
end
