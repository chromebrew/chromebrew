require 'buildsystems/qmake'

class Qt5_tools < Qmake
  description 'Qt Tools'
  homepage 'https://github.com/qt/qttools'
  kde_5_15_githash = '15deb8f202b838b4dd1b2ff84e852171e8587881'
  version "kde-5.15.16-#{kde_5_15_githash[0, 7]}"
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception and LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/qt/qt/qttools.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3faae17116b1b1677e9a521bb435697541c2c714bd5343975e879b9b1d9e760f',
     armv7l: '3faae17116b1b1677e9a521bb435697541c2c714bd5343975e879b9b1d9e760f',
     x86_64: '9023aea543b7c9c092c168c378f37292db1b0dcc850d669ac77cd812371d433f'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'libtinfo' => :build
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
  depends_on 'vulkan_headers' => :build
end
