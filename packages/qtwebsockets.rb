require 'package'

class Qtwebsockets < Package
  description 'Qt Websockets'
  homepage 'https://www.qt.io/'
  version '5.15.9'
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtwebsockets.git'
  git_hashtag "v#{version}-lts-lgpl"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtwebsockets/5.15.9_armv7l/qtwebsockets-5.15.9-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtwebsockets/5.15.9_armv7l/qtwebsockets-5.15.9-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtwebsockets/5.15.9_x86_64/qtwebsockets-5.15.9-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '52f7ef8f8520c59ccfb81546449e5a444ab99f479289027a860c1bd19816c2ed',
     armv7l: '52f7ef8f8520c59ccfb81546449e5a444ab99f479289027a860c1bd19816c2ed',
     x86_64: '5c252f73cf45897a79652d3623f7e40e5c337dcd1902a19b6d7ccea95b5c275e'
  })

  depends_on 'qt5_base'

  def self.build
    system 'qmake && make'
  end

  def self.install
    system 'make', "prefix=#{CREW_PREFIX}", "INSTALL_ROOT=#{CREW_DEST_DIR}", 'install'
  end
end
