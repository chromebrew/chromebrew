require 'package'

class Qt5_webglplugin < Package
  description 'Qt WebGL Plugin'
  homepage 'https://www.qt.io/'
  version '5.15.11-ddcff45'
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtwebglplugin.git'
  git_hashtag 'ddcff45e8f2ca9f229017b3ded62327d2fb50af2' # from kde/5.15 branch

  binary_url({})
  binary_sha256({})

  depends_on 'qt5_base' # R
  depends_on 'qt5_websockets' # R

  def self.build
    system 'qmake'
    system 'make'
  end

  def self.install
    system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
  end
end
