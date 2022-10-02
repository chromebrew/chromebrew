require 'package'

class Qtbase < Package
  description 'Qt Base (Core, Gui, Widgets, Network, ...)'
  homepage 'https://code.qt.io/cgit/qt/qtbase'
  version '5.15.6-e44097b'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception and LGPL-3'
  compatibility 'all'
  source_url 'https://invent.kde.org/qt/qt/qtbase.git'
  git_branch 'kde/5.15'                                                                                               git_hashtag 'e44097b63d17ba3178a637df7fac51ddc51cb48b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtbase/5.15.6-e44097b_armv7l/qtbase-5.15.6-e44097b-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtbase/5.15.6-e44097b_armv7l/qtbase-5.15.6-e44097b-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtbase/5.15.6-e44097b_i686/qtbase-5.15.6-e44097b-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtbase/5.15.6-e44097b_x86_64/qtbase-5.15.6-e44097b-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ca02b27e74c4eb9837952b67e27a850cdbc14232c0f52d7aeaef1adfb536003d',
     armv7l: 'ca02b27e74c4eb9837952b67e27a850cdbc14232c0f52d7aeaef1adfb536003d',
       i686: '6accea3943da14a48fc599a06b952d92e37169a3ebd7841fb170d1d3a9010d5c',
     x86_64: 'f87df14b7431d95d09ac742d0789e30a786016107fca1b3cc842763f32548f1e'
  })

  depends_on 'alsa_plugins'
  depends_on 'cups'
  depends_on 'ffmpeg'
  depends_on 'fontconfig'
  depends_on 'freetds'
  depends_on 'gstreamer'
  depends_on 'harfbuzz'
  depends_on 'jsoncpp'
  depends_on 'pcre2'
  depends_on 'lcms'
  depends_on 'libevent'
  depends_on 'libinput'
  depends_on 'libjpeg'
  depends_on 'libvpx'
  depends_on 'protobuf'

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
