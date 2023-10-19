require 'package'

class Qt5_imageformats < Package
  description 'Qt Image Formats'
  homepage 'https://www.qt.io/'
  version '5.15.11-b22bf4d'
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtimageformats.git'
  git_hashtag 'b22bf4d0d77c7dafe8b4622f8bb45ac0b9cc9bdd' # from kde/5.15 branch

  binary_url({})
  binary_sha256({})

  depends_on 'jasper' # R
  depends_on 'libmng' # R
  depends_on 'libtiff' # R
  depends_on 'libwebp' # R
  depends_on 'qt5_base' # R

  def self.build
    system 'qmake'
    system 'make'
  end

  def self.install
    system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
  end
end
