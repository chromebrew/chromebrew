require 'package'

class Qtmultimedia < Package
  description 'Qt Multimedia'
  homepage 'https://www.qt.io/'
  version '5.15.7-f3dc189'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'all'
  source_url 'https://invent.kde.org/qt/qt/qtmultimedia.git'
  git_hashtag 'f3dc18968c437c993886d3bfb668b62344a10860'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtmultimedia/5.15.7-f3dc189_armv7l/qtmultimedia-5.15.7-f3dc189-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtmultimedia/5.15.7-f3dc189_armv7l/qtmultimedia-5.15.7-f3dc189-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtmultimedia/5.15.7-f3dc189_i686/qtmultimedia-5.15.7-f3dc189-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtmultimedia/5.15.7-f3dc189_x86_64/qtmultimedia-5.15.7-f3dc189-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'dd009ac11c9191d766972aad5263bc6d775e1e3fd57eeff0603acba7542250c1',
     armv7l: 'dd009ac11c9191d766972aad5263bc6d775e1e3fd57eeff0603acba7542250c1',
       i686: 'e6d551db835d7e9d9e897995f4fe03c58c9ec78cd2f4bbed9933048df7d1d188',
     x86_64: 'cf26c441370cb378f2f19ab01dfd58eea25b63152f1da17ecd305f1e764171a7'
  })

  depends_on 'qtbase' # R
  depends_on 'qtdeclarative' # R
  depends_on 'gstreamer' => :build
  depends_on 'alsa_lib' # R
  depends_on 'gcc' # R
  depends_on 'glib' # R
  depends_on 'glibc' # R
  depends_on 'gstreamer' # R
  depends_on 'libglvnd' # R
  depends_on 'openal' # R
  depends_on 'pulseaudio' # R

  def self.build
    system 'qmake'
    system 'make'
  end

  def self.install
    system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
  end
end
