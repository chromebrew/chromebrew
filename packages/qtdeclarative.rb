require 'package'

class Qtdeclarative < Package
  description 'Provides QML and Quick declaratives.'
  homepage 'https://www.qt.io/'
  version '5.15.9-c21cad9'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtdeclarative.git'
  git_hashtag 'c21cad9f47eb7baa40341ec9b70dadb86f65a179'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtdeclarative/5.15.9-c21cad9_armv7l/qtdeclarative-5.15.9-c21cad9-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtdeclarative/5.15.9-c21cad9_armv7l/qtdeclarative-5.15.9-c21cad9-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtdeclarative/5.15.9-c21cad9_x86_64/qtdeclarative-5.15.9-c21cad9-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6acb264684dd7ba5700a51cffa9290bffcd9c5dc4be0abc813cada3fc9972d30',
     armv7l: '6acb264684dd7ba5700a51cffa9290bffcd9c5dc4be0abc813cada3fc9972d30',
     x86_64: '287f20a952222b5c955972f23daf4aafb17aac435299ad3d2a84b91278cfec6a'
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
