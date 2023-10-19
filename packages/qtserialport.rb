require 'package'

class Qtserialport < Package
  description 'Qt Serial Port'
  homepage 'https://www.qt.io/'
  version '5.15.9'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtserialport.git'
  git_hashtag "v#{version}-lts-lgpl"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtserialport/5.15.9_armv7l/qtserialport-5.15.9-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtserialport/5.15.9_armv7l/qtserialport-5.15.9-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtserialport/5.15.9_x86_64/qtserialport-5.15.9-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '3780226fe05793c8477213aab9a42a3e7d972661efac04b811b3b1d8f2e72e51',
     armv7l: '3780226fe05793c8477213aab9a42a3e7d972661efac04b811b3b1d8f2e72e51',
     x86_64: '9084b52ba54e4083fb87254e4bd87172b72a4b8a4cf65734267e36e0d7d4f60c'
  })

  depends_on 'qt5_base'

  def self.build
    system 'qmake && make'
  end

  def self.install
    system 'make', "prefix=#{CREW_PREFIX}", "INSTALL_ROOT=#{CREW_DEST_DIR}", 'install'
  end
end
