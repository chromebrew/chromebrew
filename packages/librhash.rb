require 'package'

class Librhash < Package
  description 'RHash is a console utility for computing and verifying hash sums of files.'
  homepage 'http://rhash.anz.ru/'
  version '1.4.6'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/rhash/RHash.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c5a49ffb6a41926f89456d2e9bb06c8c75680c4a17c6bbf2e6b065673e51a10c',
     armv7l: 'c5a49ffb6a41926f89456d2e9bb06c8c75680c4a17c6bbf2e6b065673e51a10c',
       i686: '979be5fa75c3ea75258a3f0ade6f7854b29f0933be8702d06779c05dadfcc3cb',
     x86_64: 'a5efd90ae1544559c9ddf6b4c2d698b6eb41135090526a321acf871d8e432ace'
  })

  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'gcc_lib' # R

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX}\
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
