require 'package'

class Qttools < Package
  description 'Qt Tools'
  homepage 'https://github.com/qt/qttools'
  version '5.15.9-5649efd'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception and LGPL-3'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://invent.kde.org/qt/qt/qttools.git'
  git_hashtag '5649efd376ed7dbb171905e9edebbd547d1f73eb'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qttools/5.15.9-5649efd_armv7l/qttools-5.15.9-5649efd-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qttools/5.15.9-5649efd_armv7l/qttools-5.15.9-5649efd-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qttools/5.15.9-5649efd_x86_64/qttools-5.15.9-5649efd-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '96d2802e5210aaf3b93926202d79832fb8d641152bd0d33aedf92fa20bf04719',
     armv7l: '96d2802e5210aaf3b93926202d79832fb8d641152bd0d33aedf92fa20bf04719',
     x86_64: 'fe800718c747ffc4867a974def71df43a72cd3bdc76f98654b762495f12026f7'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'mesa' # R
  depends_on 'qtbase' # R
  depends_on 'libtinfo' => :build
  depends_on 'libglvnd' # R
  depends_on 'llvm16_lib' # R
  depends_on 'qtdeclarative' # R

  def self.build
    system 'qmake'
    system 'make'
  end

  def self.install
    system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
  end
end
