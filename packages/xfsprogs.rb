require 'package'

class Xfsprogs < Package
  description 'XFS filesystem utilities'
  homepage 'https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git/'
  version "6.11.0-#{CREW_ICU_VER}"
  license 'LGPL-2.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ec6b21bb4fc6d89796cd0473528f9d263ea0ff0dcea5b9f58fba3bdab9a97fc5',
     armv7l: 'ec6b21bb4fc6d89796cd0473528f9d263ea0ff0dcea5b9f58fba3bdab9a97fc5',
     x86_64: '60fe2d2aee8bdc9166ab6d296fe13acff482ae5168d2ab1f178e562df744ae98'
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
