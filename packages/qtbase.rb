require 'package'

class Qtbase < Package
  description 'Qt Base (Core, Gui, Widgets, Network, ...)'
  homepage 'https://code.qt.io/cgit/qt/qtbase'
  version '5.15.2'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/qtbase-5.15.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/qtbase-5.15.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/qtbase-5.15.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/qtbase-5.15.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b528840c58650096eccde40d60b8d3283badbd14ecd251969512e6158611147b',
     armv7l: 'b528840c58650096eccde40d60b8d3283badbd14ecd251969512e6158611147b',
       i686: '4054ed51b94ad9a9ec21cd89f0ee147aaecff572c6c2218bf8018ae2be7b4de1',
     x86_64: '6f01b89c997bd5649a46103f6208fb521e3cf60ea8643adc66acbf6d758e97a0',
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
    system "git clone --branch v#{version} --depth 1 git://code.qt.io/qt/qtbase.git"
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
        '-system-freetype',
        '-no-openssl'
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
