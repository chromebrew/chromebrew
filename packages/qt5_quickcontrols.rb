# Adapted from Arch Linux qt5-quickcontrols PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/qt5-quickcontrols/trunk/PKGBUILD

require 'package'

class Qt5_quickcontrols < Package
  description 'Reusable Qt Quick based UI controls to create classic desktop-style user interfaces'
  homepage 'https://www.qt.io'
  version '5.15.11-dcc9055'
  license 'GPL3 LGPL3 FDL custom'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtquickcontrols.git'
  git_hashtag 'dcc90558d9c0cba41eec7df290943994289b0e87' # from kde/5.15 branch

  binary_url({})
  binary_sha256({})

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R

  def self.build
    system 'qmake'
    system 'make'
  end

  def self.install
    system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
  end
end
