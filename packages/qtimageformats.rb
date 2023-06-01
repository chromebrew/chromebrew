require 'package'

class Qtimageformats < Package
  description 'Qt Image Formats'
  homepage 'https://www.qt.io/'
  version '5.15.9'
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtimageformats.git'
  git_hashtag "v#{version}-lts-lgpl"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtimageformats/5.15.9_armv7l/qtimageformats-5.15.9-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtimageformats/5.15.9_armv7l/qtimageformats-5.15.9-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qtimageformats/5.15.9_x86_64/qtimageformats-5.15.9-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '72a026b708ef223ab1eeffc3a627d0fc7e50e24fd9339fe0da1d3c5a395f2e01',
     armv7l: '72a026b708ef223ab1eeffc3a627d0fc7e50e24fd9339fe0da1d3c5a395f2e01',
     x86_64: '7d15f1626b22beed5eb1f1eb442f1313bfb63df98a7fedec9f80c3801dd7d020'
  })

  depends_on 'qtbase' # R
  depends_on 'jasper' # R
  depends_on 'libmng' # R
  depends_on 'libtiff' # R
  depends_on 'libwebp' # R

  def self.build
    system 'qmake && make'
  end

  def self.install
    system 'make', "prefix=#{CREW_PREFIX}", "INSTALL_ROOT=#{CREW_DEST_DIR}", 'install'
  end
end
