require 'package'

class Librhash < Package
  description 'RHash is a console utility for computing and verifying hash sums of files.'
  homepage 'http://rhash.anz.ru/'
  version '1.4.6-1'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/rhash/RHash.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '88216436ff14c06c624d554fb9a8a774880ee4955b56a4fa211fb12be013b62d',
     armv7l: '88216436ff14c06c624d554fb9a8a774880ee4955b56a4fa211fb12be013b62d',
       i686: '4154b377ccdc58559c555699901a5f9d3d27afce227d1a45e264f4f3354774d9',
     x86_64: '13bb19ecdaee1f9aa862d4ba32178a914b3fc54d668f52674dd60683f3f89630'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'openssl' # R

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
    # Needed for cmake.
    FileUtils.ln_s "#{CREW_LIB_PREFIX}/librhash.so.1", "#{CREW_DEST_LIB_PREFIX}/librhash.so.0"
  end
end
