require 'package'

class Qt5_svg < Package
  description 'Provides classes for displaying the contents of SVG files.'
  homepage 'https://www.qt.io/'
  version '5.15.11-7d6e373'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtsvg.git'
  git_hashtag '7d6e373c7db9c05ef586db0eb50c87cd894229ad' # from kde/5.15 branch

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_svg/5.15.11-7d6e373_armv7l/qt5_svg-5.15.11-7d6e373-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_svg/5.15.11-7d6e373_armv7l/qt5_svg-5.15.11-7d6e373-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_svg/5.15.11-7d6e373_x86_64/qt5_svg-5.15.11-7d6e373-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '36231cdc4c997d8d667ecf71d17e6810ebacf7efe84e54f876ea57c34b7fe705',
     armv7l: '36231cdc4c997d8d667ecf71d17e6810ebacf7efe84e54f876ea57c34b7fe705',
     x86_64: 'c650cd8aa10f2178ddf50af0dfbbbe70dce28c16615ba98f61197e0c34ec9f76'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R
  depends_on 'zlibpkg' # R

  def self.build
    system 'qmake'
    system 'make'
  end

  def self.install
    system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
  end
end
