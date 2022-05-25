require 'buildsystems/qmake'

class Qt5_xmlpatterns < Qmake
  description 'Qt XML Patterns'
  homepage 'https://www.qt.io/'
  version '5.15.11-lts-lgpl'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtxmlpatterns.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_xmlpatterns/5.15.11-lts-lgpl_armv7l/qt5_xmlpatterns-5.15.11-lts-lgpl-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_xmlpatterns/5.15.11-lts-lgpl_armv7l/qt5_xmlpatterns-5.15.11-lts-lgpl-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_xmlpatterns/5.15.11-lts-lgpl_x86_64/qt5_xmlpatterns-5.15.11-lts-lgpl-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6d02261468a54794314b55e9ffdd84ebba62c66b4f44a5d3339fc264ec61c564',
     armv7l: '6d02261468a54794314b55e9ffdd84ebba62c66b4f44a5d3339fc264ec61c564',
     x86_64: 'a2b20fd168f685d8dd85f3a0fe4fe66c8f7c057776382571ee19e5994a326226'
  })

  depends_on 'qt5_base' # R
end
