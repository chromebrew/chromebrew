require 'package'

class Qt5_websockets < Package
  description 'Qt Websockets'
  homepage 'https://www.qt.io/'
  version '5.15.11-d41bb9f'
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtwebsockets.git'
  git_hashtag 'd41bb9f4f7ab9d5ff184ef94cf2f6ff7cf01de00' # from kde/5.15 branch

  binary_url({})
  binary_sha256({})

  depends_on 'qt5_base'

  def self.build
    system 'qmake'
    system 'make'
  end

  def self.install
    system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
  end
end
