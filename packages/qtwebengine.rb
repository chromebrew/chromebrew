# Adapted from Arch Linux qt5-webengine PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/qt5-webengine/trunk/PKGBUILD

require 'package'

class Qtwebengine < Package
  description 'Provides support for web applications using the Chromium browser project'
  homepage 'https://www.qt.io'
  version '5.15.11-3d23b37'
  license 'LGPL3 LGPL2.1 BSD'
  compatibility 'all'
  source_url 'https://invent.kde.org/qt/qt/qtwebengine.git'
  git_hashtag '3d23b379a7c0a87922f9f5d9600fde8c4e58f1fd'

  depends_on 'freetype' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'gperf' => :build
  depends_on 'jsoncpp' => :build
  depends_on 'libglvnd' # R
  depends_on 'libjpeg' # R
  depends_on 'libxcomposite' => :build
  depends_on 'libxkbfile' => :build
  depends_on 'libxrandr' => :build
  depends_on 'libxss' => :build
  depends_on 'node' => :build
  depends_on 'pciutils' => :build
  depends_on 'pipewire' => :build
  depends_on 'poppler'  => :build
  depends_on 'qtbase' # R
  depends_on 'qtdeclarative' # R
  depends_on 'qtlocation' => :build
  depends_on 'qttools' => :build
  depends_on 'qtwebchannel' => :build
  depends_on 'zlibpkg' # R

  def self.patch
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
  end

  def self.build
    # Nodebrew need to be used to have node installed, otherwise quit.
    abort if `nodebrew ls`.include?('not installed')
    # "# Update catapult for python3 compatibility"
    # "rm -r src/3rdparty/chromium/third_party/catapult"
    # "mv $srcdir/catapult src/3rdparty/chromium/third_party"
    system "qmake CONFIG+=force_debug_info -- \
    -proprietary-codecs \
    -system-ffmpeg \
    -webp \
    -spellchecker \
    -webengine-icu \
    -webengine-kerberos \
    -webengine-webrtc-pipewire"
    system 'make -j1'
  end

  def self.install
    system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
  end
end
