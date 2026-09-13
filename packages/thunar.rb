require 'buildsystems/autotools'
require 'convenience_functions'

class Thunar < Autotools
  description 'Thunar File Manager'
  homepage 'https://docs.xfce.org/xfce/thunar/Start'
  version '4.20.10'
  license 'GPL-2+ and LGPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://archive.xfce.org/src/xfce/thunar/#{version.rpartition('.')[0]}/thunar-#{version}.tar.bz2"
  source_sha256 'a5a32b51028dc821155e44cdec025fe70398bae193c619ae6ba8b1babf6f49f1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '164da8d45d1667cdbf1678aefb9d5bb6c41c680c4324e4887443d9e12f0dcf36',
     armv7l: '164da8d45d1667cdbf1678aefb9d5bb6c41c680c4324e4887443d9e12f0dcf36',
     x86_64: '434b0b63488d7e98016f353a123076307d26359d9b86de2f22b1a00504d52f83'
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
