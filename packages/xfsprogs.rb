require 'package'

class Xfsprogs < Package
  description 'XFS filesystem utilities'
  homepage 'https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git/'
  version '6.5.0'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '11346e490774fd09e12b234d71a487ed3ac3686d57814b0ef90cfb33d0b6c145',
     armv7l: '11346e490774fd09e12b234d71a487ed3ac3686d57814b0ef90cfb33d0b6c145',
       i686: '8dc50a04c13a40f2d6bc663af487b3003bc27f0800be2d39847658f18894b66c',
     x86_64: '9c6c7e554f35bb08a13e2d1ff31b032f6da0080238f1db00c2871584e6b80c37'
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
