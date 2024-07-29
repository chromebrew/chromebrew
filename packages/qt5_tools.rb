require 'buildsystems/qmake'

class Qt5_tools < Qmake
  description 'Qt Tools'
  homepage 'https://github.com/qt/qttools'
  version 'kde-5.15.14-f82ed36'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qttools.git'
  git_hashtag 'f82ed367d1b80b69d738cfcde534b75854a45476'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4bf3d78b1ffd262bd5cb718c3b2eee22510eb20efadd907e688e56e405eda9d9',
     armv7l: '4bf3d78b1ffd262bd5cb718c3b2eee22510eb20efadd907e688e56e405eda9d9',
     x86_64: '1e4621ac6e8ab9216f6ef0418381513ceaa952f2ee6524aa31837afa9d8f362f'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'libtinfo' => :build
  depends_on 'llvm17_lib' # R
  depends_on 'mesa' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
end
