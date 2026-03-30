require 'buildsystems/autotools'
require 'convenience_functions'

class Thunar < Autotools
  description 'Thunar File Manager'
  homepage 'https://docs.xfce.org/xfce/thunar/Start'
  version '4.20.8'
  license 'GPL-2+ and LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://archive.xfce.org/src/xfce/thunar/#{version.rpartition('.')[0]}/thunar-#{version}.tar.bz2"
  source_sha256 'cc735954d948a88eba2e40016a94c598f876309b736686c9f4d0273a05870c69'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '00a0ce275f5b4d77665714b71b75c66ff9527b91602ee675a473096fff6aae10',
     armv7l: '00a0ce275f5b4d77665714b71b75c66ff9527b91602ee675a473096fff6aae10',
     x86_64: 'f885bfaf4100ae45d7405fd810672ff776ed831bbd90ac76fcb846f755e8f8ec'
  })

  depends_on 'at_spi2_core' => :library
  depends_on 'cairo' => :library
  depends_on 'exo' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'gtk3' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'libexif' => :library
  depends_on 'libgudev' => :executable
  depends_on 'libice' => :library
  depends_on 'libnotify' => :executable
  depends_on 'libsm' => :library
  depends_on 'libx11' => :library
  depends_on 'libxfce4ui' => :library
  depends_on 'libxfce4util' => :library
  depends_on 'pango' => :library
  depends_on 'pcre2' => :library
  depends_on 'xfce4_panel' => :library
  depends_on 'xfconf' => :library
  depends_on 'zlib' => :library

  def self.prebuild
    ConvenienceFunctions.libtoolize('glib-2.0', 'glib')
    ConvenienceFunctions.libtoolize('harfbuzz')
    ConvenienceFunctions.libtoolize('libuuid', 'util_linux')
  end

  def self.postbuild
    # Remove systemd.
    FileUtils.rm_rf "#{CREW_DEST_PREFIX}/lib" if ARCH.eql?('x86_64')
  end

  autotools_configure_options '--enable-gio-unix \
    --enable-gudev \
    --enable-exif \
    --enable-pcre \
    --disable-static \
    --enable-notifications'

  run_tests
end
