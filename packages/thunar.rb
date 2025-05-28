require 'buildsystems/autotools'
require 'convenience_functions'

class Thunar < Autotools
  description 'Thunar File Manager'
  homepage 'https://docs.xfce.org/xfce/thunar/Start'
  version '4.20.0'
  license 'GPL-2+ and LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://archive.xfce.org/src/xfce/thunar/#{version.rpartition('.')[0]}/thunar-#{version}.tar.bz2"
  source_sha256 '27731a76f3aecf3752b1ca35afad89e264c52244f70083d933507dd4a17548b0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '238fd7945241cb22b77a93bb1b158b7fdec3ec9a41f6734c5b5ee56dbf6265c0',
     armv7l: '238fd7945241cb22b77a93bb1b158b7fdec3ec9a41f6734c5b5ee56dbf6265c0',
     x86_64: '45745314c506b418ce986d2d3106c764953071f74202d46316a701bea5f038e7'
  })

  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'desktop_file_utilities' # R
  depends_on 'exo' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'hicolor_icon_theme' # R
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
  depends_on 'wayland' # R
  depends_on 'xdg_base' # R
  depends_on 'xfce4_panel' # R
  depends_on 'xfconf' # R

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
