require 'buildsystems/qmake'

class Qt5_networkauth < Qmake
  description 'Qt Network Authentication'
  homepage 'https://www.qt.io/'
  version '5.15.11-lts-lgpl'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtnetworkauth.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_networkauth/5.15.11-lts-lgpl_armv7l/qt5_networkauth-5.15.11-lts-lgpl-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_networkauth/5.15.11-lts-lgpl_armv7l/qt5_networkauth-5.15.11-lts-lgpl-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_networkauth/5.15.11-lts-lgpl_x86_64/qt5_networkauth-5.15.11-lts-lgpl-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f94b79f92aee598dcdd6e27eb157dfae0e3f8f563e4f6eba0a7070828d6a6c24',
     armv7l: 'f94b79f92aee598dcdd6e27eb157dfae0e3f8f563e4f6eba0a7070828d6a6c24',
     x86_64: '445b9996d014044fe3bd3b369161c9067cd5e7937873b665c3d1499e7f557b50'
  })

  depends_on 'qt5_base' # R
end
