require 'buildsystems/qmake'

class Qt5_location < Qmake
  description 'Qt Location and Positioning'
  homepage 'https://www.qt.io/'
  version '5.15.11-48a17e8'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtlocation.git'
  git_hashtag '48a17e88fc1df5b6ae82a9787466226c830bcbf2' # from kde/5.15 branch

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_location/5.15.11-48a17e8_armv7l/qt5_location-5.15.11-48a17e8-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_location/5.15.11-48a17e8_armv7l/qt5_location-5.15.11-48a17e8-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_location/5.15.11-48a17e8_x86_64/qt5_location-5.15.11-48a17e8-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '042e590572e947277854b90900efdd19dff2c500bee634c58ac5de385f9fc384',
     armv7l: '042e590572e947277854b90900efdd19dff2c500bee634c58ac5de385f9fc384',
     x86_64: 'cb1105335c5ead0dd7ccf89e0fbddf161756d53a43eef3602f8480d547a769f5'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
  depends_on 'zlibpkg' # R
end
