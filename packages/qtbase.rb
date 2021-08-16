require 'package'

class Qtbase < Package
  description 'Qt Base (Core, Gui, Widgets, Network, ...)'
  homepage 'https://code.qt.io/cgit/qt/qtbase'
  @_ver = '5.15'
  version @_ver
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception and LGPL-3'
  compatibility 'all'
  source_url 'https://invent.kde.org/qt/qt/qtbase.git'
  git_hashtag "kde/#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtbase/5.15_armv7l/qtbase-5.15-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtbase/5.15_armv7l/qtbase-5.15-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtbase/5.15_x86_64/qtbase-5.15-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '8554431fc8f552380aa8822d440559c9fd2bbe00314d96ed5939637ef3a329e6',
     armv7l: '8554431fc8f552380aa8822d440559c9fd2bbe00314d96ed5939637ef3a329e6',
     x86_64: '9b58c01ad6d16498b1cd8a35ac97026f75dc5d19b586a0a3759362757ddd8bf7'
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
