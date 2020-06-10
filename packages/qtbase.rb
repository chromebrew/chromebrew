require 'package'

class Qtbase < Package
  description 'Qt Base (Core, Gui, Widgets, Network, ...)'
  homepage 'https://github.com/qt/qtbase'
  version '5.12.3'
  compatibility 'all'
  source_url 'http://download.qt.io/official_releases/qt/5.12/5.12.3/submodules/qtbase-everywhere-src-5.12.3.tar.xz'
  source_sha256 'fddfd8852ef7503febeed67b876d1425160869ae2b1ae8e10b3fb0fedc5fe701'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/qtbase-5.12.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/qtbase-5.12.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/qtbase-5.12.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/qtbase-5.12.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1d03332f2eb04d0f74d35ac1120c5d8cc2fa28b13c12649ec1778dba6fde0f6d',
     armv7l: '1d03332f2eb04d0f74d35ac1120c5d8cc2fa28b13c12649ec1778dba6fde0f6d',
       i686: '60cfbe8822c86ca48c0fa847744b7d4aa8829e31fc18396b7a6cd9b6bd047b3a',
     x86_64: '58a2294909587a37caf520df334bee992fa4fcc793985a90ff1eb18fa96e3ab9',
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
