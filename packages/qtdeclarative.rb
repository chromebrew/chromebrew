require 'package'

class Qtdeclarative < Package
  description 'Provides QML and Quick declaratives.'
  homepage 'https://www.qt.io/'
  version '5.15.7-959b1ac'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception and LGPL-3'
  compatibility 'all'
  source_url 'https://invent.kde.org/qt/qt/qtdeclarative.git'
  git_hashtag '959b1ac3b7c699ef67ec81155e6e1e579d4e1df7'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtdeclarative/5.15.7-959b1ac_armv7l/qtdeclarative-5.15.7-959b1ac-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtdeclarative/5.15.7-959b1ac_armv7l/qtdeclarative-5.15.7-959b1ac-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtdeclarative/5.15.7-959b1ac_i686/qtdeclarative-5.15.7-959b1ac-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtdeclarative/5.15.7-959b1ac_x86_64/qtdeclarative-5.15.7-959b1ac-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b241e41b7a33a30dc716ccb48e579304914a4b5c5e6ced59a10d038153cb8ed0',
     armv7l: 'b241e41b7a33a30dc716ccb48e579304914a4b5c5e6ced59a10d038153cb8ed0',
       i686: '5c2360441a9f83f58167fcf9e4bd79cbaeda9b4e55bf24e7d5cabcf96f25d850',
     x86_64: '7ce9e821601c926a00f7fa85e7590e8a5fc925df530daa8dd99781cf10d41be2'
  })

  depends_on 'qtbase' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R

  def self.build
    system 'qmake'
    system 'make || make'
  end

  def self.install
    system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
  end
end
