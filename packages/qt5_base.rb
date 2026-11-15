require 'package'

class Qt5_base < Package
  description 'Qt Base (Core, Gui, Widgets, Network, ...)'
  homepage 'https://code.qt.io/cgit/qt/qtbase'
  version "kde-5.15.18-#{CREW_ICU_VER}"
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/qt/qt/qtbase.git'
  git_hashtag "v#{version.split('-')[1]}-lts-lgpl"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'da67e181c57076bd6fb946c40721384114022e8223736fc900ce6ca997684c0c',
     armv7l: 'da67e181c57076bd6fb946c40721384114022e8223736fc900ce6ca997684c0c',
     x86_64: '2ab6daab8662f4837d238046d592c19f84f32bc4715353ce83776bba277c11fa'
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
  depends_on 'glibc_lib' => :library
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
  depends_on 'mysql' => :library if ARCH.eql?('x86_64')
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
  # Note that mysql can't be built for 32-bit arm, so we do
  # not want that dependency from preventing arm builds here.

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
      bin = File.basename(filename)
      FileUtils.ln_s "#{CREW_PREFIX}/share/Qt-5/bin/#{bin}", "#{CREW_DEST_PREFIX}/bin/#{bin}"
    end
  end
end
