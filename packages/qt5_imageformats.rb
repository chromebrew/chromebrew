require 'buildsystems/qmake'

class Qt5_imageformats < Qmake
  description 'Qt Image Formats'
  homepage 'https://www.qt.io/'
  version '5.15.11-b22bf4d'
  license 'GPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtimageformats.git'
  git_hashtag 'b22bf4d0d77c7dafe8b4622f8bb45ac0b9cc9bdd' # from kde/5.15 branch
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_imageformats/5.15.11-b22bf4d_armv7l/qt5_imageformats-5.15.11-b22bf4d-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_imageformats/5.15.11-b22bf4d_armv7l/qt5_imageformats-5.15.11-b22bf4d-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_imageformats/5.15.11-b22bf4d_x86_64/qt5_imageformats-5.15.11-b22bf4d-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1126352d31d224d68d023d39e3987d34c975a33aa1e077fa96a049889fafc305',
     armv7l: '1126352d31d224d68d023d39e3987d34c975a33aa1e077fa96a049889fafc305',
     x86_64: '80a8d685a8c71a1f9c9c3ef14a6a83bdc14248aa3dda2e5921566fa3841d041c'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'jasper' # R
  depends_on 'libglvnd' # R
  depends_on 'libmng' # R
  depends_on 'libtiff' # R
  depends_on 'libwebp' # R
  depends_on 'qt5_base' # R
end
