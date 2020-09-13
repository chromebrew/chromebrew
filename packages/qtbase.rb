require 'package'

class Qtbase < Package
  description 'Qt Base (Core, Gui, Widgets, Network, ...)'
  homepage 'https://github.com/qt/qtbase'
  version '5.15.1'
  compatibility 'all'
  source_url 'http://download.qt.io/official_releases/qt/5.15/5.15.1/submodules/qtbase-everywhere-src-5.15.1.tar.xz'
  source_sha256 '33960404d579675b7210de103ed06a72613bfc4305443e278e2d32a3eb1f3d8c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/qtbase-5.15.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/qtbase-5.15.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/qtbase-5.15.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/qtbase-5.15.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '435c4acd25637c6d7f547ca12ff327f5019abe2fda9ba2e27babbe5d7da41abc',
     armv7l: '435c4acd25637c6d7f547ca12ff327f5019abe2fda9ba2e27babbe5d7da41abc',
       i686: 'b0c8d00a7330421b3ee08bd25d4db907119a50a70006f145b61f34fadc850169',
     x86_64: 'bacd7fe55f8eb855ad3c09769f588c69185971269c3ec845e15f7163a2300c35',
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
           '-system-freetype',
           '-no-openssl'
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
