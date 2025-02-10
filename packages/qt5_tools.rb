require 'buildsystems/qmake'

class Qt5_tools < Qmake
  description 'Qt Tools'
  homepage 'https://github.com/qt/qttools'
  kde_5_15_githash = '0378d3e541f40bc9c5433eac70d3949ddff9cfc4'
  version "kde-5.15.15-#{kde_5_15_githash[0, 7]}"
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception and LGPL-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://invent.kde.org/qt/qt/qttools.git'
  git_hashtag kde_5_15_githash
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6cf8f5bbf1efe4fa207ab2d0fbf31afdc01cb6790421628150411e409d2dcaf9',
     armv7l: '6cf8f5bbf1efe4fa207ab2d0fbf31afdc01cb6790421628150411e409d2dcaf9',
     x86_64: 'd9f032cadb2505b9e8d4c73ce732cca977b47490b23663b875a738f6c9db4cea'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libglvnd' # R
  depends_on 'libtinfo' => :build
  depends_on 'llvm19_lib' # R
  depends_on 'mesa' # R
  depends_on 'qt5_base' # R
  depends_on 'qt5_declarative' # R
end
