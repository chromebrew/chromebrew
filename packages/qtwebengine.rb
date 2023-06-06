# Adapted from Arch Linux qt5-webengine PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/qt5-webengine/trunk/PKGBUILD
# & LFS build documentation at https://www.linuxfromscratch.org/blfs/view/svn/x/qtwebengine.html

require 'package'
require_relative 'qtbase'

class Qtwebengine < Package
  description 'Provides support for web applications using the Chromium browser project'
  homepage 'https://www.qt.io'
  version '5.15.14'
  @qt_pkgver = Qtwebengine.version.to_s.gsub(/-.*/, '')
  @qt_basever = Qtbase.version.to_s.gsub(/-.*/, '')
  license 'LGPL3 LGPL2.1 BSD'
  compatibility 'x86_64'
  source_url 'https://anduin.linuxfromscratch.org/BLFS/qtwebengine/qtwebengine-5.15.14.tar.xz'
  source_sha256 '1475c004860585b22af13a2b719ef10992fad58f1c145bf5cb43fbc86a3a67d2'

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtwebengine/5.15.14_x86_64/qtwebengine-5.15.14-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: '5bd9db7445283a9f0206864fb108a2b24b23ef35e979e42d8694a80ad4848231'
  })

  depends_on 'alsa_lib' # R
  depends_on 'dbus' # R
  depends_on 'expat' # R
  depends_on 'ffmpeg' # R (This has to be patched for chromium.)
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'glib' => :build
  depends_on 'glibc' # R
  depends_on 'gperf' => :build
  depends_on 'harfbuzz' # R
  depends_on 'icu4c' # R
  depends_on 'jsoncpp' => :build
  depends_on 'lcms' # R
  depends_on 'libevent' # R
  depends_on 'libglvnd' # R
  depends_on 'libjpeg' # R
  depends_on 'libpng' # R
  depends_on 'libvpx' # R
  depends_on 'libwebp' # R
  depends_on 'libxcomposite' => :build
  depends_on 'libxkbfile' => :build
  depends_on 'libxml2' # R
  depends_on 'libxrandr' => :build
  depends_on 'libxslt' # R
  depends_on 'libxss' => :build
  depends_on 'minizip' # R
  depends_on 'nodebrew' => :build
  depends_on 'nss' # R
  depends_on 'opus' # R
  depends_on 'pciutils' # R
  depends_on 'pipewire' => :build
  depends_on 'poppler'  => :build
  depends_on 'pulseaudio' # R
  depends_on 'qtbase' # R
  depends_on 'qtdeclarative' # R
  depends_on 'qtlocation' # R
  depends_on 'qttools' # R
  depends_on 'qtwebchannel' # R
  depends_on 're2' # R
  depends_on 'snappy' # R
  depends_on 'zlibpkg' # R

  def self.patch
    # Patches from lfs: https://www.linuxfromscratch.org/blfs/view/svn/x/qtwebengine.html
    downloader 'https://www.linuxfromscratch.org/patches/blfs/svn/qtwebengine-5.15.14-build_fixes-1.patch', 'SKIP'
    system 'patch -Np1 -i qtwebengine-5.15.14-build_fixes-1.patch'
    downloader 'https://www.linuxfromscratch.org/patches/blfs/svn/qtwebengine-5.15.14-ffmpeg5_fixes-1.patch', 'SKIP'
    system 'patch -Np1 -i qtwebengine-5.15.14-ffmpeg5_fixes-1.patch'
    downloader 'https://www.linuxfromscratch.org/patches/blfs/svn/qtwebengine-5.15.14-icu_73-1.patch', 'SKIP'
    system 'patch -Np1 -i qtwebengine-5.15.14-icu_73-1.patch'
    FileUtils.mkdir_p '.git'
    FileUtils.mkdir_p 'src/3rdparty/chromium/.git'
    system "sed -e '/^MODULE_VERSION/s/5.*/#{@qt_basever}/' -i .qmake.conf"
    system "sed -i 's/NINJAJOBS/NINJA_JOBS/' src/core/gn_run.pro", exception: false
    system "find -type f -name \"*.pr[io]\" | xargs sed -i -e 's|INCLUDEPATH += |&$$QTWEBENGINE_ROOT/include |'"
    system "sed -e '/link_pulseaudio/s/false/true/' -i src/3rdparty/chromium/media/media_options.gni"
    system 'sed -e \'s/\\^(?i)/(?i)^/\' -i src/3rdparty/chromium/tools/metrics/ukm/ukm_model.py'
    system "sed \"s,mode = 'rU,mode = 'r,g\" -i src/3rdparty/chromium/tools/grit/grit/util.py"
  end

  def self.prebuild
    # Nodejs is needed for this install, and nodejs is installed by
    # nodebrew.
    return unless `nodebrew ls`.include?('not installed')

    puts 'nodejs is not configured!'.lightred
    puts "Please run 'crew postinstall nodebrew' for more info.".orange
    abort
  end

  def self.build
    unless File.file?('Makefile')
      system "qmake CONFIG+=force_debug_info -- \
      -proprietary-codecs \
      -system-ffmpeg \
      -webp \
      -spellchecker \
      -webengine-icu \
      -webengine-kerberos"
    end
    @counter = 1
    @counter_max = 5
    loop do
      break if Kernel.system 'NINJAJOBS=4 make'

      puts "Make iteration #{@counter} of #{@counter_max}...".orange

      @counter += 1
      break if @counter > @counter_max
    end
  end

  def self.install
    system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
    # This is needed because this is a frankenstein build of @qt_pkgver and @qt_basever,
    # which is the version of the other QT files.
    system "sed -e 's|#{@qt_pkgver} |#{@qt_basever} |' -i #{CREW_DEST_LIB_PREFIX}/cmake/*/*Config.cmake"
  end
end
