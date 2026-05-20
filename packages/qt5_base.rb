require 'package'

class Qt5_base < Package
  description 'Qt Base (Core, Gui, Widgets, Network, ...)'
  homepage 'https://code.qt.io/cgit/qt/qtbase'
  kde_5_15_githash = '2529f7f0c2333d437089c775c9c30f624d1fd5bc'
  version "kde-5.15.16-#{kde_5_15_githash[0, 7]}-#{CREW_ICU_VER}"
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/qt/qt/qtbase.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '52a076cad63deec005e5ca947c54410494d9a8e77f9d26754628cace10bb304e',
     armv7l: '52a076cad63deec005e5ca947c54410494d9a8e77f9d26754628cace10bb304e',
     x86_64: '4d3f4459f9ca3f5c76932da91a2992037e03c138185fc91f0cef7cb96529ceb3'
  })

  depends_on 'alsa_plugins' => :build
  depends_on 'at_spi2_core' => :library
  depends_on 'cairo' => :library
  depends_on 'cups' => :library
  depends_on 'dbus' => :library
  depends_on 'eudev' => :library
  depends_on 'ffmpeg' => :build
  depends_on 'fontconfig' => :library
  depends_on 'freetds' => :library
  depends_on 'freetype' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'gstreamer' => :build
  depends_on 'gtk3' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'icu4c' => :library
  depends_on 'jsoncpp' => :build
  depends_on 'krb5' => :library
  depends_on 'lcms' => :build
  depends_on 'libdrm' => :library
  depends_on 'libevent' => :build
  depends_on 'libglvnd' => :library
  depends_on 'libice' => :library
  depends_on 'libinput' => :library
  depends_on 'libjpeg_turbo' => :library
  depends_on 'libpng' => :library
  depends_on 'libsm' => :library
  depends_on 'libvpx' => :build
  depends_on 'libx11' => :library
  depends_on 'libxcb' => :library
  depends_on 'libxext' => :library
  depends_on 'libxkbcommon' => :library
  depends_on 'mesa' => :library
  depends_on 'mtdev' => :library
  depends_on 'pango' => :library
  depends_on 'pcre2' => :library
  depends_on 'protobuf' => :build
  depends_on 'unixodbc' => :library
  depends_on 'xcb_proto' => :build
  depends_on 'xcb_util' => :build
  depends_on 'xcb_util_cursor' => :build
  depends_on 'xcb_util_image' => :library
  depends_on 'xcb_util_keysyms' => :library
  depends_on 'xcb_util_renderutil' => :library
  depends_on 'xcb_util_wm' => :library
  depends_on 'xcb_util_xrm' => :build
  depends_on 'zlib' => :library
  depends_on 'zstd' => :library
  if ARCH.eql?('x86_64')
    # Note that mysql can't be built for 32-bit arm, so we do
    # not want that dependency from preventing arm builds here.
    depends_on 'mysql' => :library
  end

  def self.build
    system "./configure \
           --prefix=#{CREW_PREFIX}/share/Qt-5 \
           --libdir=#{CREW_LIB_PREFIX} \
           -confirm-license \
           -inotify \
           -nomake examples \
           -nomake tests \
           -opensource \
           -release"
    system 'make'
  end

  def self.install
    system 'make', "INSTALL_ROOT=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    Dir["#{CREW_DEST_PREFIX}/share/Qt-5/bin/*"].select { |f| File.executable?(f) }.each do |filename|
      FileUtils.ln_s(filename, File.join(CREW_DEST_PREFIX, 'bin', File.basename(filename)))
    end
  end
end
