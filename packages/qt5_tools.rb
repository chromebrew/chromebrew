require 'buildsystems/qmake'

class Qt5_tools < Qmake
  description 'Qt Tools'
  homepage 'https://github.com/qt/qttools'
  version '5.15.11-38ae810'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qttools.git'
  git_hashtag '38ae810be3fb4984f75b55a16d3413e35d701af1' # from kde/5.15 branch
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_tools/5.15.11-38ae810_armv7l/qt5_tools-5.15.11-38ae810-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_tools/5.15.11-38ae810_armv7l/qt5_tools-5.15.11-38ae810-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_tools/5.15.11-38ae810_x86_64/qt5_tools-5.15.11-38ae810-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2f8ee51fd04a90af6ae36435acd9db326464235ec752e3796450a3fe5a5cdbb6',
     armv7l: '2f8ee51fd04a90af6ae36435acd9db326464235ec752e3796450a3fe5a5cdbb6',
     x86_64: '6f279180b9a03233b6b7e593736fec1ac9891773c3830b8b1dc72025174518aa'
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
