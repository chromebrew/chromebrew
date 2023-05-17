require 'package'

class Qtwayland < Package
  description 'Qt Wayland'
  homepage 'https://www.qt.io/'
  version '5.15.9-c4c3fc6'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtwayland.git'
  git_hashtag 'c4c3fc69250c01cb35aaae5ea1ea2bcc8236dff0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtwayland/5.15.9-c4c3fc6_armv7l/qtwayland-5.15.9-c4c3fc6-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtwayland/5.15.9-c4c3fc6_armv7l/qtwayland-5.15.9-c4c3fc6-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtwayland/5.15.9-c4c3fc6_x86_64/qtwayland-5.15.9-c4c3fc6-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '47bcd7e8a823a8e3abd7e1c20979a4188d88fe0046599c17d1e4255b0e4f55ea',
     armv7l: '47bcd7e8a823a8e3abd7e1c20979a4188d88fe0046599c17d1e4255b0e4f55ea',
     x86_64: 'de2c05689ae25a1a78c62ba851b4e3a616916e80896d4f8b703a67bfde8a3542'
  })

  depends_on 'freetype' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'glib' # R
  depends_on 'harfbuzz' # R
  depends_on 'libdrm' # R
  depends_on 'libglvnd' # R
  depends_on 'libx11' # R
  depends_on 'libxcomposite' # R
  depends_on 'libxext' # R
  depends_on 'libxkbcommon' # R
  depends_on 'qtbase' # R
  depends_on 'qtdeclarative' # R
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
