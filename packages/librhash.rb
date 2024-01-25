require 'package'

class Librhash < Package
  description 'RHash is a console utility for computing and verifying hash sums of files.'
  homepage 'http://rhash.anz.ru/'
  version '1.4.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/rhash/RHash.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fdb6b38162bd3a25a3797a2e151262b45338bd56915555f97402308d6290b4c8',
     armv7l: 'fdb6b38162bd3a25a3797a2e151262b45338bd56915555f97402308d6290b4c8',
       i686: 'e3a3a89ca257d2132713f6770aa66774af98def033e2eaa44225da969e7ef1f6',
     x86_64: 'bdcf6b36fe18f40f153b083daca45f3b634face054642ff469076afa46934299'
  })

  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'gcc_lib' # R

  def self.build
    system "mold -run ./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX}\
            --cc=#{CREW_TGT}-gcc \
            --ar=#{CREW_TGT}-gcc-ar \
            --enable-gettext \
            --enable-openssl \
            --extra-cflags='#{CREW_COMMON_FLAGS}'"
    system 'make'
  end

  def self.check
    system 'make check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-lib-headers'
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-pkg-config'
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-lib-so-link'
  end
end
