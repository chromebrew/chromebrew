require 'package'

class Libarchive < Package
  description 'Multi-format archive and compression library.'
  homepage 'https://www.libarchive.org/'
  @_ver = '3.6.2'
  version "#{@_ver}-2"
  license 'BSD, BSD-2, BSD-4 and public-domain'
  compatibility 'all'
  source_url "https://www.libarchive.org/downloads/libarchive-#{@_ver}.tar.xz"
  source_sha256 '9e2c1b80d5fbe59b61308fdfab6c79b5021d7ff4ff2489fb12daf0a96a83551d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libarchive/3.6.2-2_armv7l/libarchive-3.6.2-2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libarchive/3.6.2-2_armv7l/libarchive-3.6.2-2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libarchive/3.6.2-2_i686/libarchive-3.6.2-2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libarchive/3.6.2-2_x86_64/libarchive-3.6.2-2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '083845ff184ba1f7a302a0ff726ccf32353c5c91a5d2df3b92d3c732c16d2a14',
     armv7l: '083845ff184ba1f7a302a0ff726ccf32353c5c91a5d2df3b92d3c732c16d2a14',
       i686: '733706856e6127ff3513f4c88927adf07a8ad7d27dbb8afe17dbe21096ec5fe7',
     x86_64: '148a1207346590f14a7243552f5620cf3c928fd50726e3d2349ede7acf7c21be'
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
  depends_on 'gcc' # R

  def self.build
    system "mold -run ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    # As per Arch pkgbuild. This fixes epiphany builds.
    system "sed -i 's/iconv//g' #{CREW_DEST_LIB_PREFIX}/pkgconfig/libarchive.pc"
  end
end
