require 'package'

class Qtscript < Package
  description 'Qt Script Tools'
  homepage 'https://www.qt.io/'
  version '5.15.9'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtscript.git'
  git_hashtag "v#{version}-lts-lgpl"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtscript/5.15.9_armv7l/qtscript-5.15.9-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtscript/5.15.9_armv7l/qtscript-5.15.9-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtscript/5.15.9_x86_64/qtscript-5.15.9-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '0e417164035660ec9c676cf00021406e4d67140677576a7a0d9b42a5ef22eb99',
     armv7l: '0e417164035660ec9c676cf00021406e4d67140677576a7a0d9b42a5ef22eb99',
     x86_64: '154c0dcaf09c29c8954e7b842abc1ac1356643f916f5ad08f2f504642cdf71a1'
  })

  depends_on 'qtbase'

  def self.build
    system 'qmake && make'
  end

  def self.install
    system 'make', "prefix=#{CREW_PREFIX}", "INSTALL_ROOT=#{CREW_DEST_DIR}", 'install'
  end
end
