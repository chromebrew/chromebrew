require 'package'

class Qt5_tools < Package
  description 'Qt Tools'
  homepage 'https://github.com/qt/qttools'
  version '5.15.11-38ae810'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qttools.git'
  git_hashtag '38ae810be3fb4984f75b55a16d3413e35d701af1' # from kde/5.15 branch

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qt5_tools/5.15.11-38ae810_x86_64/qt5_tools-5.15.11-38ae810-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
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

  def self.build
    system 'qmake'
    system 'make'
  end

  def self.install
    system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
  end
end
