require 'package'

class Libidn2 < Package
  description 'GNU Libidn is a fully documented implementation of the Stringprep, Punycode and IDNA 2003 specifications.'
  homepage 'https://www.gnu.org/software/libidn/'
  version '2.3.1'
  license 'GPL-2+ and LGPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libidn/libidn2-2.3.1.tar.gz'
  source_sha256 '8af684943836b8b53965d5f5b6714ef13c26c91eaa36ce7d242e3d21f5d40f2d'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.1_armv7l/libidn2-2.3.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.1_armv7l/libidn2-2.3.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.1_i686/libidn2-2.3.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.1_x86_64/libidn2-2.3.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'd5451f73189a53bbdd500b23c781750d688d9b8ee4763eecca8323eace221566',
     armv7l: 'd5451f73189a53bbdd500b23c781750d688d9b8ee4763eecca8323eace221566',
       i686: '03df0cdc3848415a7e08e2026eab5a3a50c6943c1980223dac8d0579cdbdc3be',
     x86_64: '2ade8b8171841b7a911b1802d2dbee0f890537687131e16515a4155c9167187a'
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
