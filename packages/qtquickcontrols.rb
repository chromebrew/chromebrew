# Adapted from Arch Linux qt5-quickcontrols PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/qt5-quickcontrols/trunk/PKGBUILD

require 'package'

class Qtquickcontrols < Package
  description 'Reusable Qt Quick based UI controls to create classic desktop-style user interfaces'
  homepage 'https://www.qt.io'
  version '5.15.7-c7dae5f'
  license 'GPL3 LGPL3 FDL custom'
  compatibility 'all'
  source_url 'https://invent.kde.org/qt/qt/qtquickcontrols.git'
  git_hashtag 'c7dae5f6041d6c076311f2d8ed13fcfe3598be70'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtquickcontrols/5.15.7-c7dae5f_armv7l/qtquickcontrols-5.15.7-c7dae5f-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtquickcontrols/5.15.7-c7dae5f_armv7l/qtquickcontrols-5.15.7-c7dae5f-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtquickcontrols/5.15.7-c7dae5f_i686/qtquickcontrols-5.15.7-c7dae5f-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtquickcontrols/5.15.7-c7dae5f_x86_64/qtquickcontrols-5.15.7-c7dae5f-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '97a9348c5314f186818b88b02b3e1202c329d85809a86c8efaf8b86345f5c307',
     armv7l: '97a9348c5314f186818b88b02b3e1202c329d85809a86c8efaf8b86345f5c307',
       i686: 'cb42e0c1b104309a56db6279ca4348c6a29aa525ff00f9cb53828c9659fd842e',
     x86_64: '2e90a6def26022bb2bf5ca027b9e538bfb2ad40a883827eebd90ac37bb6e864c'
  })

  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qtbase' # R
  depends_on 'qtdeclarative' # R

  def self.build
    system 'qmake'
    system 'make'
  end

  def self.install
    system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
  end
end
