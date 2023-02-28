require 'package'

class Libarchive < Package
  description 'Multi-format archive and compression library.'
  homepage 'https://www.libarchive.org/'
  @_ver = '3.6.2'
  version "#{@_ver}-1"
  license 'BSD, BSD-2, BSD-4 and public-domain'
  compatibility 'all'
  source_url "https://www.libarchive.org/downloads/libarchive-#{@_ver}.tar.xz"
  source_sha256 '9e2c1b80d5fbe59b61308fdfab6c79b5021d7ff4ff2489fb12daf0a96a83551d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libarchive/3.6.2-1_armv7l/libarchive-3.6.2-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libarchive/3.6.2-1_armv7l/libarchive-3.6.2-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libarchive/3.6.2-1_i686/libarchive-3.6.2-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libarchive/3.6.2-1_x86_64/libarchive-3.6.2-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '79d1a1b9dd755eca23827575de2a5337675f50ae90ba39c7821947eaf0ca66f7',
     armv7l: '79d1a1b9dd755eca23827575de2a5337675f50ae90ba39c7821947eaf0ca66f7',
       i686: '9367d373e29a70798e4beb787551bc603fd31c5391f1b531cdd3c614e79d463a',
     x86_64: '24980bda1ab951b1b68b7f4270dd0ba356969d0a203e7810c14614b4735ad517'
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
    # As per Arch pkgbuild. This fixes epiphany builds.
    system "sed -i 's/iconv//g' #{CREW_DEST_LIB_PREFIX}/pkgconfig/libarchive.pc"
  end
end
