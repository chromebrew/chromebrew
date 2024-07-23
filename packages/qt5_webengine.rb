# Adapted from Arch Linux qt5-webengine PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/qt5-webengine/trunk/PKGBUILD
# & LFS build documentation at https://www.linuxfromscratch.org/blfs/view/svn/x/qtwebengine.html

require 'package'
require_relative 'qt5_base'

class Qt5_webengine < Package
  description 'Provides support for web applications using the Chromium browser project'
  homepage 'https://www.qt.io'
  version '5.15.15'
  @qt_pkgver = Qt5_webengine.version.to_s.gsub(/-.*/, '')
  @qt_basever = Qt5_base.version.to_s.gsub(/-.*/, '')
  license 'LGPL3 LGPL2.1 BSD'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://anduin.linuxfromscratch.org/BLFS/qtwebengine/qtwebengine-5.15.15.tar.xz'
  source_sha256 '53b2f184c8b40bcac88b13f9f565a3d849f1ccfcc4f7344823ccc4265fb80445'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8b5cd6d79fdbc00d8eb9bc2b389814f979b487865192122d9369056dc431e7e7',
     armv7l: '8b5cd6d79fdbc00d8eb9bc2b389814f979b487865192122d9369056dc431e7e7',
     x86_64: '0b71f2615effd2e5c6628e3a18429d8ed06267b6d472b06c8b6e7b3e80732a74'
  })

  depends_on 'alsa_lib' # R
  depends_on 'dbus' # R
  depends_on 'expat' # R
  depends_on 'ffmpeg' # R (This has to be patched for chromium.)
  depends_on 'fontconfig' # R
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
  depends_on 'libjpeg_turbo' # R
  depends_on 'libpng' # R
  depends_on 'libvpx' # R
  depends_on 'libwebp' # R
  depends_on 'libx11' # R
  depends_on 'libxcb' # R
  depends_on 'libxcomposite' # R
  depends_on 'libxdamage' # R
  depends_on 'libxext' # R
  depends_on 'libxfixes' # R
  depends_on 'libxkbcommon' # R
  depends_on 'libxkbfile' => :build
  depends_on 'libxml2' # R
  depends_on 'libxrandr' # R
  depends_on 'libxrender' # R
  depends_on 'libxslt' # R
  depends_on 'libxss' => :build
  depends_on 'libxtst' # R
  depends_on 'minizip' # R
  depends_on 'nodebrew' => :build
  depends_on 'nss' # R
  depends_on 'opus' # R
  depends_on 'pciutils' # R
  depends_on 'pipewire' => :build
  depends_on 'poppler'  => :build
  depends_on 'pulseaudio' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
  depends_on 'qt5_location' # R
  depends_on 'qt5_tools' # R
  depends_on 'qt5_webchannel' # R
  depends_on 're2' # R
  depends_on 'snappy' # R
  depends_on 'zlibpkg' # R

  def self.patch
    # Patches from lfs: https://www.linuxfromscratch.org/blfs/view/svn/x/qtwebengine.html
    downloader 'https://www.linuxfromscratch.org/patches/blfs/svn/qtwebengine-5.15.15-build_fixes-1.patch',
               'a9e248414302b6fbd19e0404142e5ad082fb4a45eaf6f96d1b847a7b4bf8e1bd'
    system 'patch -Np1 -i qtwebengine-5.15.15-build_fixes-1.patch'
    downloader 'https://www.linuxfromscratch.org/patches/blfs/svn/qtwebengine-5.15.15-ffmpeg5_fixes-1.patch',
               '9f45c97d2aeb99ba8eea90cdd3b380c03218ca4d4c88e356f622e094971dd34a'
    system 'patch -Np1 -i qtwebengine-5.15.15-ffmpeg5_fixes-1.patch'
    # Further Python3 patches
    system "sed -i 's,qtwebengine_checkForPython2,qtwebengine_checkForPython,g' src/buildtools/config/support.pri"
    system "sed -i 's,webengine-python2,webengine-python,g' src/buildtools/config/support.pri"
    FileUtils.mkdir_p '.git'
    FileUtils.mkdir_p 'src/3rdparty/chromium/.git'
    system "sed -e '/^MODULE_VERSION/s/5.*/#{@qt_basever}/' -i .qmake.conf"
    system "sed -i 's/NINJAJOBS/NINJA_JOBS/' src/core/gn_run.pro", exception: false
    system "find -type f -name \"*.pr[io]\" | xargs sed -i -e 's|INCLUDEPATH += |&$$QTWEBENGINE_ROOT/include |'"
    system "sed -e '/link_pulseaudio/s/false/true/' -i src/3rdparty/chromium/media/media_options.gni"
    system 'sed -e \'s/\\^(?i)/(?i)^/\' -i src/3rdparty/chromium/tools/metrics/ukm/ukm_model.py'
    system "sed \"s,mode = 'rU,mode = 'r,g\" -i src/3rdparty/chromium/tools/grit/grit/util.py"
    # Fix issue with system re2 causing build to fail: https://bugs.gentoo.org/913923
    system "sed -i 's/use_system_re2=true/use_system_re2=false/g' src/core/config/linux.pri"
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
      system "qmake QMAKE_LFLAGS=-fuse-ld=#{CREW_LINKER} -- \
      -proprietary-codecs \
      -system-ffmpeg \
      -webp \
      -spellchecker \
      -webengine-icu \
      -webengine-kerberos"
    end
    @counter = 1
    @counter_max = 20
    loop do
      break if Kernel.system "NINJAJOBS=#{CREW_NPROC} make"

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
