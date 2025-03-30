require 'buildsystems/qmake'

class Qt5_webchannel < Qmake
  description 'Provides access to QObject or QML objects from HTML clients for seamless integration of Qt applications with HTML/JavaScript clients'
  homepage 'https://www.qt.io'
  kde_5_15_githash = 'b375bde968f7b9c273adfb8a89f9a6fb888f9af6'
  version "kde-5.15.16-#{kde_5_15_githash[0, 7]}"
  license 'GPL3 LGPL3 FDL custom'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/qt/qt/qtwebchannel.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1a4addc61811e6c925b9da177a5d081104ed22d0c306ae58d4235cffea24e1c7',
     armv7l: '1a4addc61811e6c925b9da177a5d081104ed22d0c306ae58d4235cffea24e1c7',
     x86_64: 'bc2a5b65b2e7a42bfb22ecc64567edc41b66da09d7d59f53d33f2e3658874a13'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
end
