require 'buildsystems/qmake'

class Qt5_serialport < Qmake
  description 'Qt Serial Port'
  homepage 'https://www.qt.io/'
  version '5.15.11-3380465'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qtserialport.git'
  git_hashtag '3380465d5d4977326616c5e57789a81681be650e' # from kde/5.15 branch

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_serialport/5.15.11-3380465_armv7l/qt5_serialport-5.15.11-3380465-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_serialport/5.15.11-3380465_armv7l/qt5_serialport-5.15.11-3380465-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_serialport/5.15.11-3380465_x86_64/qt5_serialport-5.15.11-3380465-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'eb2c1d0a8d43064df1d9fcde90fa5391a4623b6ccd6c59eac009ddc951af6d9e',
     armv7l: 'eb2c1d0a8d43064df1d9fcde90fa5391a4623b6ccd6c59eac009ddc951af6d9e',
     x86_64: 'f0044c04788d6de615d606a812a133b9ed7e6e7361ae1e8a3ddbce7a066e7216'
  })

  depends_on 'eudev' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'qt5_base' # R
end
