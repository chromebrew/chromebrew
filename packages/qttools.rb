require 'package'

class Qttools < Package
  description 'Qt Tools'
  homepage 'https://github.com/qt/qttools'
  version '5.15.7-c4750dd'
  license 'FDL, GPL-2, GPL-3, GPL-3-with-qt-exception and LGPL-3'
  compatibility 'all'
  source_url 'https://invent.kde.org/qt/qt/qttools.git'
  git_hashtag 'c4750dd02070ce246ff98cc5d137193825043912'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qttools/5.15.7-c4750dd_armv7l/qttools-5.15.7-c4750dd-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qttools/5.15.7-c4750dd_armv7l/qttools-5.15.7-c4750dd-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qttools/5.15.7-c4750dd_i686/qttools-5.15.7-c4750dd-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qttools/5.15.7-c4750dd_x86_64/qttools-5.15.7-c4750dd-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2aec1354a1b2bf672a0c91c5e06e80378a77faccd3f275b1039a5857aa9462ec',
     armv7l: '2aec1354a1b2bf672a0c91c5e06e80378a77faccd3f275b1039a5857aa9462ec',
       i686: 'f601314a281f7f64bd23f5603f2702cad362bfdd32f7d969415bc1b2107fc899',
     x86_64: '0d7b2e4341b4cceca8ab22710f89e933c5bf35d784a030d67e314b4d8879529e'
  })

  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'mesa' # R
  depends_on 'qtbase' # R
  depends_on 'libtinfo'
  depends_on 'libglvnd' # R
  depends_on 'llvm' # R
  depends_on 'qtdeclarative' # R

  def self.build
    system 'qmake'
    system 'make'
  end

  def self.install
    system "make INSTALL_ROOT=#{CREW_DEST_DIR} install"
  end
end
