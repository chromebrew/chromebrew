require 'package'

class Qtcharts < Package
  description 'Qt Charts'
  homepage 'https://www.qt.io/'
  version '5.15.9'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtcharts.git'
  git_hashtag "v#{version}-lts-lgpl"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtcharts/5.15.9_armv7l/qtcharts-5.15.9-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtcharts/5.15.9_armv7l/qtcharts-5.15.9-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtcharts/5.15.9_x86_64/qtcharts-5.15.9-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '49874b941b487eb185d559e5bd1d588f125b0dea966c6fa506d1ff1b1958bc0e',
     armv7l: '49874b941b487eb185d559e5bd1d588f125b0dea966c6fa506d1ff1b1958bc0e',
     x86_64: '60662bd8df31f884a31e7b4e8cdd8aebc5f1ec8c111d417444e38ee62f23fd74'
  })

  depends_on 'qtbase'

  def self.build
    system 'qmake && make'
  end

  def self.install
    system 'make', "prefix=#{CREW_PREFIX}", "INSTALL_ROOT=#{CREW_DEST_DIR}", 'install'
  end
end
