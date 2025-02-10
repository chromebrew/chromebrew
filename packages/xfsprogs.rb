require 'package'

class Xfsprogs < Package
  description 'XFS filesystem utilities'
  homepage 'https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git/'
  version "6.12.0-#{CREW_ICU_VER}"
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cece01bad384d71762c2941bab3ec26eb61dced7f308c578d2669c9dcebbae19',
     armv7l: 'cece01bad384d71762c2941bab3ec26eb61dced7f308c578d2669c9dcebbae19',
     x86_64: '1cb8708d6c9bd0664500acc609d3fb5e7315c1b95802e7adb7d5262fe8c972f6'
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
    system "DEBUG=-DNDEBUG ./configure #{CREW_CONFIGURE_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DIST_ROOT=#{CREW_DEST_DIR} install install-dev"
  end
end
