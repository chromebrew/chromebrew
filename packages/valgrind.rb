require 'package'

class Valgrind < Package
  description 'Valgrind is an instrumentation framework for building dynamic analysis tools.'
  homepage 'https://valgrind.org/'
  version '3.17'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://sourceware.org/pub/valgrind/valgrind-3.17.0.tar.bz2'
  source_sha256 'ad3aec668e813e40f238995f60796d9590eee64a16dff88421430630e69285a2'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/valgrind/3.17_armv7l/valgrind-3.17-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/valgrind/3.17_armv7l/valgrind-3.17-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/valgrind/3.17_i686/valgrind-3.17-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/valgrind/3.17_x86_64/valgrind-3.17-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '0cf8ca23893761153fee6ffb58af0a731244fc5e36d3686fb2d9dcd870b2e250',
     armv7l: '0cf8ca23893761153fee6ffb58af0a731244fc5e36d3686fb2d9dcd870b2e250',
       i686: 'd2bca1735bc552d38a905ac27bd667067f9ed435c42bced73f5390711320c51a',
     x86_64: 'ac13fa3ae34fdcd2284fbc866b2959c89e9287e60b6704e3dd8d73a165a54956'
  })

  depends_on 'glibc' # R

  def self.build
    system 'autoreconf -fvi'
    system "env #{CREW_ENV_OPTIONS}
      RANLIB=gcc-ranlib \
      AR=gcc-ar \
      ./configure #{CREW_OPTIONS} \
       --enable-lto"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
