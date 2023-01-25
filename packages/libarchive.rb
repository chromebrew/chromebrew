require 'package'

class Libarchive < Package
  description 'Multi-format archive and compression library.'
  homepage 'https://www.libarchive.org/'
  @_ver = '3.6.2'
  version @_ver
  license 'BSD, BSD-2, BSD-4 and public-domain'
  compatibility 'all'
  source_url "https://www.libarchive.org/downloads/libarchive-#{@_ver}.tar.xz"
  source_sha256 '9e2c1b80d5fbe59b61308fdfab6c79b5021d7ff4ff2489fb12daf0a96a83551d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libarchive/3.6.2_armv7l/libarchive-3.6.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libarchive/3.6.2_armv7l/libarchive-3.6.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libarchive/3.6.2_i686/libarchive-3.6.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libarchive/3.6.2_x86_64/libarchive-3.6.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ea79c0fb02a8fcedaecb62560c31229a9e75d2c9c610d098a5b8f6edb6259b53',
     armv7l: 'ea79c0fb02a8fcedaecb62560c31229a9e75d2c9c610d098a5b8f6edb6259b53',
       i686: 'facc3060ac2b1fbc32adfca9c4603261d54044788d48dcb91521ca12c6c37192',
     x86_64: 'b47fba0e0591e1e05c38d3cf74c44d49ba9ff8a4bb2bd6a02bdfa61d9c098802'
  })

  depends_on 'acl' # R
  depends_on 'attr' # R
  depends_on 'bz2' # R
  depends_on 'glibc' # R
  depends_on 'icu4c' # R
  depends_on 'libxml2' # R
  depends_on 'lz4' # R
  depends_on 'openssl' # R
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R
  depends_on 'zstd' # R

  def self.build
    raise StandardError, 'Please remove libiconv before building.' if File.exist?("#{CREW_LIB_PREFIX}/libcharset.so")

    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
