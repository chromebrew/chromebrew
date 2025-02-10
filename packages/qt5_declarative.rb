require 'buildsystems/qmake'

class Qt5_declarative < Qmake
  description 'Provides QML and Quick declaratives.'
  homepage 'https://www.qt.io/'
  kde_5_15_githash = '310c124dac82d711ab15309a9cb0b9d95db9ea8f'
  version "kde-5.15.15-#{kde_5_15_githash[0, 7]}"
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception and LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/qt/qt/qtdeclarative.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '827076a4e33aac1aaaba76265d15c6a7004e69d152308d39adb2fbbfc1375d0f',
     armv7l: '827076a4e33aac1aaaba76265d15c6a7004e69d152308d39adb2fbbfc1375d0f',
     x86_64: 'b6e06d28586cf0f429ef7685280b6c0d8b6f3fb39e7ce9a2b1438147b01001c0'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R
  depends_on 'vulkan_headers' => :build
end
