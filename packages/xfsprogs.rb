require 'package'

class Xfsprogs < Package
  description 'XFS filesystem utilities'
  homepage 'https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git/'
  version "6.19.0-#{CREW_ICU_VER}"
  license 'LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '426217685ae0316b24e6611dfd3aaeef1a43acf89d7a589da226f827cc04925a',
     armv7l: '426217685ae0316b24e6611dfd3aaeef1a43acf89d7a589da226f827cc04925a',
     x86_64: '950bbf87240e82b35d880e047199cc9622d28c8eb4690cd254fe088b59c57e99'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'gettext' => :build
  depends_on 'glibc' => :library
  depends_on 'icu4c' => :library
  depends_on 'libeconf' => :library
  depends_on 'libinih' => :library
  depends_on 'liburcu' => :library
  depends_on 'lvm2' => :library
  depends_on 'util_linux' => :executable

  def self.build
    system 'make configure'
    system "DEBUG=-DNDEBUG ./configure #{CREW_CONFIGURE_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DIST_ROOT=#{CREW_DEST_DIR} install install-dev"
  end
end
