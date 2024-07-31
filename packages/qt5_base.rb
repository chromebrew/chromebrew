require 'package'

class Qt5_base < Package
  description 'Qt Base (Core, Gui, Widgets, Network, ...)'
  homepage 'https://code.qt.io/cgit/qt/qtbase'
  version 'kde-5.15.14-9f9a56d'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtbase.git'
  git_hashtag '9f9a56d750caff8b4459e7e9bf82f1f4d725f72f'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b819c57bac88d433ffd516af06f22f197d57b0d738358206bafe6d96ee7d0bf3',
     armv7l: 'b819c57bac88d433ffd516af06f22f197d57b0d738358206bafe6d96ee7d0bf3',
     x86_64: '6bebd128aa79373bbe50fbd91948e02e929dc0dc644701f74428a611f000db20'
  })

  depends_on 'alsa_plugins' => :build
  depends_on 'at_spi2_core' # R
  depends_on 'cairo' # R
  depends_on 'cups' # R
  depends_on 'dbus' # R
  depends_on 'eudev' # R
  depends_on 'ffmpeg' => :build
  depends_on 'fontconfig' # R
  depends_on 'freetds' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'gdk_pixbuf' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'gstreamer' => :build
  depends_on 'gtk3' # R
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'jsoncpp' => :build
  depends_on 'krb5' # R
  depends_on 'lcms' => :build
  depends_on 'libdrm' # R
  depends_on 'libevent' => :build
  depends_on 'libglvnd' # R
  depends_on 'libice' # R
  depends_on 'libinput' # R
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpng' # R
  depends_on 'libsm' # R
  depends_on 'libvpx' => :build
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxext' # R
  depends_on 'libxkbcommon' # R
  depends_on 'mesa' # R
  depends_on 'mtdev' # R
  depends_on 'mysql' if ARCH.eql?('x86_64')
  depends_on 'pango' # R
  depends_on 'pcre2' # R
  depends_on 'protobuf' => :build
  depends_on 'unixodbc' # R
  depends_on 'xcb_proto' # R
  depends_on 'xcb_util_cursor' # R
  depends_on 'xcb_util_image' # R
  depends_on 'xcb_util_keysyms' # R
  depends_on 'xcb_util' # R
  depends_on 'xcb_util_renderutil' # R
  depends_on 'xcb_util_wm' # R
  depends_on 'xcb_util_xrm' # R
  depends_on 'zlib' # R
  depends_on 'zstd' # R

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
    Dir["#{CREW_DEST_PREFIX}/share/Qt-5/bin/*"].each do |filename|
      next unless File.executable?(filename)
      FileUtils.ln_s(filename, File.join(CREW_DEST_PREFIX, 'bin', File.basename(filename)))
    end
  end
end
