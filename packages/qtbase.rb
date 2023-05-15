require 'package'

class Qtbase < Package
  description 'Qt Base (Core, Gui, Widgets, Network, ...)'
  homepage 'https://code.qt.io/cgit/qt/qtbase'
  version '5.15.9-8415277'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtbase.git'
  git_hashtag '84152777a48af444a902bbf4df8b38146171c20d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtbase/5.15.9-8415277_armv7l/qtbase-5.15.9-8415277-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtbase/5.15.9-8415277_armv7l/qtbase-5.15.9-8415277-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtbase/5.15.9-8415277_x86_64/qtbase-5.15.9-8415277-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e57671fa0d6a5abcdde8eb7c06a15be2cb810c687b29f3ef095e693bd18befce',
     armv7l: 'e57671fa0d6a5abcdde8eb7c06a15be2cb810c687b29f3ef095e693bd18befce',
     x86_64: 'c4c3860f30518cf8aebcc147e42814c44f8db2b862480c51d86f24754445c9aa'
  })

  depends_on 'alsa_plugins' => :build
  depends_on 'at_spi2_core' # R
  depends_on 'cairo' => :build
  depends_on 'cups' # R
  depends_on 'dbus' # R
  depends_on 'eudev' # R
  depends_on 'ffmpeg' => :build
  depends_on 'fontconfig' => :build
  depends_on 'freetds' # R
  depends_on 'freetype' # R
  depends_on 'gcc' # R
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
  depends_on 'libinput' # R
  depends_on 'libjpeg' # R
  depends_on 'libpng' # R
  depends_on 'libvpx' => :build
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxext' # R
  depends_on 'libxkbcommon' # R
  depends_on 'mesa' # R
  depends_on 'mtdev' # R
  depends_on 'pango' # R
  depends_on 'pcre2' # R
  depends_on 'protobuf' => :build
  depends_on 'unixodbc' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}/share/Qt-5",
           "--libdir=#{CREW_LIB_PREFIX}",
           '-nomake', 'examples',
           '-nomake', 'tests',
           '-verbose',
           '-release',
           '-opensource',
           '-confirm-license',
           '-inotify',
           '-system-pcre',
           '-system-zlib',
           '-system-libpng',
           '-system-libjpeg',
           '-system-freetype'
    system 'bin/qmake CONFIG+=fat-static-lto -- -redo'
    system 'make'
  end

  def self.install
    system 'make', "INSTALL_ROOT=#{CREW_DEST_DIR}", 'install'
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    Dir.chdir "#{CREW_DEST_PREFIX}/share/Qt-5/bin" do
      system "find . -type f -exec ln -s #{CREW_PREFIX}/share/Qt-5/bin/{} #{CREW_DEST_PREFIX}/bin/{} \\;"
    end
  end
end
