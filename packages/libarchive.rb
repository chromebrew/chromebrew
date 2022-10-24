require 'package'

class Libarchive < Package
  description 'Multi-format archive and compression library.'
  homepage 'https://www.libarchive.org/'
  @_ver = '3.6.1'
  version @_ver
  license 'BSD, BSD-2, BSD-4 and public-domain'
  compatibility 'all'
  source_url "https://www.libarchive.org/downloads/libarchive-#{@_ver}.tar.xz"
  source_sha256 '5a411aceb978f43e626f0c2d1812ddd8807b645ed892453acabd532376c148e6'

  binary_url({
        i686: 'file:///usr/local/tmp/packages/libarchive-3.6.1-chromeos-i686.tar.zst',
      x86_64: 'file:///usr/local/tmp/packages/libarchive-3.6.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
        i686: '8ac07aaccabd5eacc1702e63879fc1c2cd2640e30028738996944644af3a4a8d',
      x86_64: '5dfe44a35baa0065e86d06e3cc6a0c721d8b2abef4f28d0cc561a0bc9e36af19'
  })

  depends_on 'acl' # R
  depends_on 'bz2' # R
  depends_on 'glibc' # R
  depends_on 'libxml2' # R
  depends_on 'lz4' # R
  depends_on 'openssl' # R
  depends_on 'xzutils' # R
  depends_on 'zlibpkg' # R

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
