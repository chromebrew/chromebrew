require 'buildsystems/autotools'
require 'convenience_functions'

class Thunar < Autotools
  description 'Thunar File Manager'
  homepage 'https://docs.xfce.org/xfce/thunar/Start'
  version '4.20.9'
  license 'GPL-2+ and LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://archive.xfce.org/src/xfce/thunar/#{version.rpartition('.')[0]}/thunar-#{version}.tar.bz2"
  source_sha256 'eb09869ce93b12ed285678967f55f243c833f2baf2fb10c9844ac7648d9270cb'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '98a9b1d4337507ece5a6d5dedfb8885b1a66dd001ebf048555a5f8f1559325fb',
     armv7l: '98a9b1d4337507ece5a6d5dedfb8885b1a66dd001ebf048555a5f8f1559325fb',
     x86_64: '88e686190d703d3aea9c4ccb3ea1153ff1e50390731165fe7cb959a8842ed722'
  })

  depends_on 'at_spi2_core' => :library
  depends_on 'cairo' => :executable
  depends_on 'cairo' => :library
  depends_on 'exo' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gtk3' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'libexif' => :library
  depends_on 'libgudev' => :executable
  depends_on 'libice' => :executable
  depends_on 'libice' => :library
  depends_on 'libnotify' => :executable
  depends_on 'libsm' => :executable
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
