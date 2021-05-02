require 'package'

class Qtbase < Package
  description 'Qt Base (Core, Gui, Widgets, Network, ...)'
  homepage 'https://code.qt.io/cgit/qt/qtbase'
  @_ver = '5.15.2'
  version @_ver + '-1'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception and LGPL-3'
  compatibility 'all'
  source_url 'SKIP'

  binary_url ({
     aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtbase/5.15.2-1_armv7l/qtbase-5.15.2-1-chromeos-armv7l.tar.xz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtbase/5.15.2-1_armv7l/qtbase-5.15.2-1-chromeos-armv7l.tar.xz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtbase/5.15.2-1_i686/qtbase-5.15.2-1-chromeos-i686.tar.xz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtbase/5.15.2-1_x86_64/qtbase-5.15.2-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: 'a3e863cc19101742af4d808cb552b954d0c8581febd8015865087ea36da0fa56',
      armv7l: 'a3e863cc19101742af4d808cb552b954d0c8581febd8015865087ea36da0fa56',
        i686: '34eedd58aac9f5a803af9e2641a645badbf6b96e501eae1aa495a271bb53037a',
      x86_64: '0d26af5842faa70ad3f1c7aa822c8e4f7c4c6f42535f1f24042f1f6e1e73df4d',
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
    system "git clone --branch v#{@_ver} --depth 1 git://code.qt.io/qt/qtbase.git"
    Dir.chdir 'qtbase' do
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
  end

  def self.install
    Dir.chdir 'qtbase' do
      system 'make', "INSTALL_ROOT=#{CREW_DEST_DIR}", 'install'
      FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
      Dir.chdir "#{CREW_DEST_PREFIX}/share/Qt-5/bin" do
        system "find . -type f -exec ln -s #{CREW_PREFIX}/share/Qt-5/bin/{} #{CREW_DEST_PREFIX}/bin/{} \\;"
      end
    end
  end
end
