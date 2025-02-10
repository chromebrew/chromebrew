require 'buildsystems/qmake'

class Qt5_script < Qmake
  description 'Qt Script Tools'
  homepage 'https://www.qt.io/'
  version '5.15.17-lts'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception, LGPL-2.1 and LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/qt/qt/qtscript.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6873176fac95c55745da9696a0e9860ddf1f65acb153196cf80c725a010d5268',
     armv7l: '6873176fac95c55745da9696a0e9860ddf1f65acb153196cf80c725a010d5268',
     x86_64: '559b0fe58ac8daa010a1515feb6847a76b562c0806500d4b71a0f8ad75477729'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'qt5_base' # R
end
