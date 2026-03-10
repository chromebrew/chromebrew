require 'package'

class Qrupdate < Package
  description 'Fortran library for fast updates of QR and Cholesky decompositions.'
  homepage 'https://sourceforge.net/projects/qrupdate/'
  version '1.1.2'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/qrupdate/qrupdate/1.2/qrupdate-1.1.2.tar.gz'
  source_sha256 'e2a1c711dc8ebc418e21195833814cb2f84b878b90a2774365f0166402308e08'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'befef8bdb1b37619e8164e57a951864fbe702ab45c8f95f69ba915fd23d370b9',
     armv7l: 'befef8bdb1b37619e8164e57a951864fbe702ab45c8f95f69ba915fd23d370b9',
       i686: 'bc827d61f4a8ed932eeba1596efe4b4f8439e2e33fabd389ccff3d88c8c113e4',
     x86_64: '41c1bcf2c8128eb44ef19338cac33e0a5f10356f4517c6e858b0cfc4dced3e39'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'lapack' # R

  def self.build
    system 'make', 'lib'
    system 'make', 'solib'
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "LIBDIR=lib#{CREW_LIB_SUFFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
