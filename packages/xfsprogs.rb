require 'package'

class Xfsprogs < Package
  description 'XFS filesystem utilities'
  homepage 'https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git/'
  version '6.9.0'
  license 'LGPL-2.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'de01befdf6802bf679cec210aeb79a3f2b3996570ee000482deef5ece4a6bc1a',
     armv7l: 'de01befdf6802bf679cec210aeb79a3f2b3996570ee000482deef5ece4a6bc1a',
     x86_64: 'ecf25239f220b2507926d43db68cbcf5a280106d40a0f72ecabe9272dec5c2a8'
  })

  depends_on 'gcc_lib' # R
  depends_on 'gettext' => :build
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'libinih' # R
  depends_on 'liburcu' # R
  depends_on 'lvm2' # R
  depends_on 'util_linux' # R

  def self.build
    system 'make configure'
    system "DEBUG=-DNDEBUG ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DIST_ROOT=#{CREW_DEST_DIR} install install-dev"
  end
end
