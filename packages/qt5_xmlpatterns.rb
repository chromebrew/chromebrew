require 'buildsystems/qmake'

class Qt5_xmlpatterns < Qmake
  description 'Qt XML Patterns'
  homepage 'https://www.qt.io/'
  kde_5_15_githash = '330c47bab8333d6dc7d4ab838afb81f29b6a32d0'
  version "kde-5.15.15-#{kde_5_15_githash[0, 7]}"
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtxmlpatterns.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a8d3c1968443284b2e1efe0ce9cbc44963dd948f4529abb623bbd4a038b16deb',
     armv7l: 'a8d3c1968443284b2e1efe0ce9cbc44963dd948f4529abb623bbd4a038b16deb',
     x86_64: 'e30e0ea2e1024758197a79a1c71d1b28ce4465cce17d9d7f435cf0a2b6de260c'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
end
