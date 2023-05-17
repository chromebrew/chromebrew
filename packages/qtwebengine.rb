# Adapted from Arch Linux qt5-webengine PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/qt5-webengine/trunk/PKGBUILD

require 'package'
require_relative 'qtbase'

class Qtwebengine < Package
  description 'Provides support for web applications using the Chromium browser project'
  homepage 'https://www.qt.io'
  version '5.15.13'
  @qt_pkgver = Qtwebengine.version.to_s.gsub(/-.*/, '')
  @qt_basever = Qtbase.version.to_s.gsub(/-.*/, '')
  license 'LGPL3 LGPL2.1 BSD'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtwebengine.git'
  git_hashtag "v#{version}-lts"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtwebengine/5.15.13_armv7l/qtwebengine-5.15.13-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtwebengine/5.15.13_armv7l/qtwebengine-5.15.13-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtwebengine/5.15.13_x86_64/qtwebengine-5.15.13-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '5b4f0f87ab95cd3bf6b597f3d5423b5a457283087c054794a5fb975e85a57cd9',
     armv7l: '5b4f0f87ab95cd3bf6b597f3d5423b5a457283087c054794a5fb975e85a57cd9',
     x86_64: 'd9708eb0508f7ff1c09b01b8155891a4dba2af2c8e0b43e16793c2a48521c24b'
  })

  depends_on 'alsa_lib' # R
  depends_on 'dbus' # R
  depends_on 'expat' # R
  depends_on 'ffmpeg' # R (This has to be patched for chromium.)
  depends_on 'freetype' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
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
  depends_on 'minizip' => :build
  depends_on 'nodebrew' => :build
  depends_on 'nss' # R
  depends_on 'opus' # R
  depends_on 'pciutils' # R
  depends_on 'pipewire' => :build
  depends_on 'poppler'  => :build
  depends_on 'qtbase' # R
  depends_on 'qtdeclarative' # R
  depends_on 'qtlocation' # R
  depends_on 'qttools' # R
  depends_on 'qtwebchannel' # R
  depends_on 're2' => :build
  depends_on 'snappy' # R
  depends_on 'zlibpkg' # R

  def self.patch
    puts "@qt_pkgver is #{@qt_pkgver} and @qt_basever is #{@qt_basever}".lightblue
    # Build & patches track Arch PKGBUILD at https://github.com/archlinux/svntogit-packages/raw/packages/qt5-webengine/trunk/PKGBUILD
    Dir.chdir('src/3rdparty') do
      system 'git checkout 87-based'
      downloader 'https://github.com/archlinux/svntogit-packages/raw/packages/qt5-webengine/trunk/qt5-webengine-chromium-python3.patch',
                 'fda4ff16790799fb285847918a677f4f3f7c0f513d4751f846ffc5aa5d873932'
      system 'patch -Np1 -i qt5-webengine-chromium-python3.patch'
      system "sed -i 's,#!/usr/bin/python,#!#{CREW_PREFIX}/python,g' chromium/build/print_python_deps.py"
      downloader 'https://github.com/archlinux/svntogit-packages/raw/packages/qt5-webengine/trunk/qt5-webengine-ffmpeg5.patch',
                 'c50d3019626183e753c53a997dc8a55938847543aa3178d4c51f377be741c693'
      system 'patch -Np1 -i qt5-webengine-ffmpeg5.patch'
      downloader 'https://github.com/archlinux/svntogit-packages/raw/packages/qt5-webengine/trunk/qt5-webengine-gcc12.patch',
                 'cf9be3ffcc3b3cd9450b1ff13535ff7d76284f73173412d097a6ab487463a379'
      system 'patch -Np1 -i qt5-webengine-gcc12.patch'
      downloader 'https://github.com/archlinux/svntogit-packages/raw/packages/qt5-webengine/trunk/qt5-webengine-pipewire-0.3.patch',
                 '5e3a3c4711d964d5152a04059a2b5c1d14bb13dd29bce370120f60e85b476b6f'
      system 'patch -Np1 -i qt5-webengine-pipewire-0.3.patch'
    end
    downloader 'https://github.com/archlinux/svntogit-packages/raw/packages/qt5-webengine/trunk/qt5-webengine-python3.patch',
               '398c996cb5b606695ac93645143df39e23fa67e768b09e0da6dbd37342a43f32'
    system 'patch -Np1 -i qt5-webengine-python3.patch'
    Dir.chdir('src/3rdparty/chromium/third_party') do
      FileUtils.rm_rf 'catapult'
      system 'git clone https://chromium.googlesource.com/catapult'
      Dir.chdir('catapult') do
        system 'git checkout 5eedfe23148a234211ba477f76fc2ea2e8529189'
      end
    end
    # From https://www.linuxfromscratch.org/blfs/view/svn/x/qtwebengine.html
    system "sed -i 's/NINJAJOBS/NINJA_JOBS/' src/core/gn_run.pro", exception: false
  end

  def self.build
    # Nodejs is needed for this install, and nodejs is installed by
    # nodebrew.
    if `nodebrew ls`.include?('not installed')
      puts 'nodejs is not configured!'.lightred
      puts "Please run 'crew postinstall nodebrew' for more info.".orange
      abort
    end
    system "qmake CONFIG+=force_debug_info -- \
    -webengine-jumbo-build \
    -proprietary-codecs \
    -system-ffmpeg \
    -webp \
    -spellchecker \
    -webengine-icu \
    -webengine-kerberos \
    -webengine-webrtc-pipewire"
    # This eventually succeeds on x86_64. Maybe a for loop here might be
    # a better choice to keep restarting make?
    system 'NINJAJOBS=4 make || NINJAJOBS=3 make || NINJAJOBS=2 make || NINJAJOBS=1 make'
  end

  def self.install
    system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
    # This is needed because this is a frankenstein build of @qt_pkgver and @qt_basever,
    # which is the version of the other QT files.
    system "sed -e 's|#{@qt_pkgver} |#{@qt_basever} |' -i #{CREW_DEST_LIB_PREFIX}/cmake/*/*Config.cmake"
  end
end
