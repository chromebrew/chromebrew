require 'package'

class Qt5_wayland < Package
  description 'Qt Wayland'
  homepage 'https://www.qt.io/'
  version '5.15.11-4de268c'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtwayland.git'
  git_hashtag '4de268cbaf6ff3b633429577f06d3d746a3b202a' # from kde/5.15 branch

  binary_url({})
  binary_sha256({})

  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'harfbuzz' # R
  depends_on 'libdrm' # R
  depends_on 'libglvnd' # R
  depends_on 'libx11' # R
  depends_on 'libxcomposite' # R
  depends_on 'libxext' # R
  depends_on 'libxkbcommon' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
  depends_on 'wayland' # R
  depends_on 'zlibpkg' # R

  def self.build
    system 'qmake'
    system 'make'
  end

  def self.install
    system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
  end
end
