require 'package'

class Qtsvg < Package
  description 'Provides classes for displaying the contents of SVG files.'
  homepage 'https://www.qt.io/'
  version '5.15.9'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtsvg.git'
  git_hashtag "v#{version}-lts-lgpl"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtsvg/5.15.9_armv7l/qtsvg-5.15.9-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtsvg/5.15.9_armv7l/qtsvg-5.15.9-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtsvg/5.15.9_x86_64/qtsvg-5.15.9-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'dae9dd08e93a3b7f7f910688e82888459325b7a8bd213eecf1c5bd149f3a5301',
     armv7l: 'dae9dd08e93a3b7f7f910688e82888459325b7a8bd213eecf1c5bd149f3a5301',
     x86_64: '97a10a120362f995bd6aceb0faf49983c1af8a7e85975fc05601e429f1669c49'
  })

  depends_on 'qt5_base'

  def self.build
    system 'qmake && make'
  end

  def self.install
    system 'make', "prefix=#{CREW_PREFIX}", "INSTALL_ROOT=#{CREW_DEST_DIR}", 'install'
  end
end
