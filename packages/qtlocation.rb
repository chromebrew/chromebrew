require 'package'

class Qtlocation < Package
  description 'Qt Location and Positioning'
  homepage 'https://www.qt.io/'
  version '5.15.9-30fb93c'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtlocation.git'
  git_hashtag '30fb93cf8521f2c0b3803903153d9034b7d7bcc2'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtlocation/5.15.9-30fb93c_armv7l/qtlocation-5.15.9-30fb93c-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtlocation/5.15.9-30fb93c_armv7l/qtlocation-5.15.9-30fb93c-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtlocation/5.15.9-30fb93c_x86_64/qtlocation-5.15.9-30fb93c-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e6f00573faf79d4b2ee2331d09202c3825d4ed0f68a711dab25b15906d852307',
     armv7l: 'e6f00573faf79d4b2ee2331d09202c3825d4ed0f68a711dab25b15906d852307',
     x86_64: '6a9b2e3c7b80f7ee9cf5f4f9721989878093dbe733330cdb92c89634f0c8c4f1'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'libglvnd' # R
  depends_on 'qtbase' # R
  depends_on 'qtdeclarative' # R
  depends_on 'zlibpkg' # R

  def self.build
    system 'qmake'
    system 'make'
  end

  def self.install
    system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
  end
end
