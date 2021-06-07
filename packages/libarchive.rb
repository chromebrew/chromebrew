require 'package'

class Libarchive < Package
  description 'Multi-format archive and compression library.'
  homepage 'https://www.libarchive.org/'
  @_ver = '3.5.1'
  version "#{@_ver}-2"
  license 'BSD, BSD-2, BSD-4 and public-domain'
  compatibility 'all'
  source_url "https://www.libarchive.org/downloads/libarchive-#{@_ver}.tar.xz"
  source_sha256 '0e17d3a8d0b206018693b27f08029b598f6ef03600c2b5d10c94ce58692e299b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libarchive/3.5.1-2_armv7l/libarchive-3.5.1-2-chromeos-armv7l.tar.xz',
    armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libarchive/3.5.1-2_armv7l/libarchive-3.5.1-2-chromeos-armv7l.tar.xz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libarchive/3.5.1-2_i686/libarchive-3.5.1-2-chromeos-i686.tar.xz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libarchive/3.5.1-2_x86_64/libarchive-3.5.1-2-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '9c1ee0cdca17abfba167d39f82fb339ca5a51fd3c10cacd55f538ae99d972655',
    armv7l: '9c1ee0cdca17abfba167d39f82fb339ca5a51fd3c10cacd55f538ae99d972655',
    i686: '71c9ae6c9722b152a3798eb15d09cc667e9207518a3ce5c75b823fa5610c64b3',
    x86_64: 'd21778e1bca3015e53dfe253eedae0b0f497c21554563d41eed6233b37a15762'
  })

  depends_on 'lz4'
  depends_on 'xzutils' => :build

  def self.build
    raise StandardError, 'Please remove libiconv before building.' if File.exist?("#{CREW_LIB_PREFIX}/libcharset.so")

    system "./configure #{CREW_OPTIONS} #{CREW_ENV_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
