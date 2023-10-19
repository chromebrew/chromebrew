require 'package'

class Qt5_base < Package
  description 'Qt Base (Core, Gui, Widgets, Network, ...)'
  homepage 'https://code.qt.io/cgit/qt/qtbase'
  version '5.15.11-ea7a183'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception and LGPL-3'
  compatibility 'x86_64'
  source_url 'https://invent.kde.org/qt/qt/qtbase.git'
  git_hashtag 'ea7a183732c17005f08ca14fd70cdd305c90396d'

  binary_url({})
  binary_sha256({})

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
  depends_on 'libjpeg' # R
  depends_on 'libpng' # R
  depends_on 'libsm' # R
  depends_on 'libvpx' => :build
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxext' # R
  depends_on 'libxkbcommon' # R
  depends_on 'mesa' # R
  depends_on 'mtdev' # R
  depends_on 'mysql' => :build if ARCH == 'x86_64'
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
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  def self.build
    @sql = ARCH == 'x86_64' ? '-sql-mysql' : ''
    system "mold -run ./configure \
           --prefix=#{CREW_PREFIX}/share/Qt-5 \
           --libdir=#{CREW_LIB_PREFIX} \
           -confirm-license \
           -inotify \
           -nomake examples \
           -nomake tests \
           -opensource \
           -release \
           #{@sql} \
           -system-freetype \
           -system-libjpeg \
           -system-libpng \
           -system-pcre \
           -system-zlib \
           -verbose \
           -xcb \
           -xcb-xlib"
    system 'mold -run bin/qmake CONFIG+=fat-static-lto -- -redo'
    @counter = 1
    @counter_max = 20
    loop do
      break if Kernel.system "make -j #{CREW_NPROC}"

      puts "Make iteration #{@counter} of #{@counter_max}...".orange

      @counter += 1
      break if @counter > @counter_max
    end
  end

  def self.install
    system 'make', "INSTALL_ROOT=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    Dir.chdir "#{CREW_DEST_PREFIX}/share/Qt-5/bin" do
      system "find . -type f -exec ln -s #{CREW_PREFIX}/share/Qt-5/bin/{} #{CREW_DEST_PREFIX}/bin/{} \\;"
    end
  end
end
