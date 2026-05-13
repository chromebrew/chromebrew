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
    aarch64: 'b54265ed3156675335f5bc43f0bfcac68da397864ecdaa3dae9e269b920b15c8',
     armv7l: 'b54265ed3156675335f5bc43f0bfcac68da397864ecdaa3dae9e269b920b15c8',
     x86_64: 'ee47512b039030603dcd058a4d4a73aae6163664e4b4b51aa34143cb096edbe4'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'gettext' => :build
  depends_on 'glibc' => :library
  depends_on 'icu4c' => :executable
  depends_on 'icu4c' => :library
  depends_on 'libeconf' => :library
  depends_on 'libinih' => :executable
  depends_on 'libinih' => :library
  depends_on 'liburcu' => :executable
  depends_on 'liburcu' => :library
  depends_on 'lvm2' => :executable
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
