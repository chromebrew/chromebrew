require 'package'

class Libidn2 < Package
  description 'GNU Libidn is a fully documented implementation of the Stringprep, Punycode and IDNA 2003 specifications.'
  homepage 'https://www.gnu.org/software/libidn/'
  version '2.3.1'
  license 'GPL-2+ and LGPL-3+'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libidn/libidn2-2.3.1.tar.gz'
  source_sha256 '8af684943836b8b53965d5f5b6714ef13c26c91eaa36ce7d242e3d21f5d40f2d'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.1_armv7l/libidn2-2.3.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.1_armv7l/libidn2-2.3.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.1_i686/libidn2-2.3.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.1_x86_64/libidn2-2.3.1-chromeos-x86_64.tpxz',
  })
  binary_sha256 ({
    aarch64: '9533e091572a2fb3aff874794327ffb752967b9952608cbccbd06321a1098323',
     armv7l: '9533e091572a2fb3aff874794327ffb752967b9952608cbccbd06321a1098323',
       i686: 'f65ae2734d93e883e32a7602bee7e494d396406addd38d675346d41c5eb34943',
     x86_64: '3a54e6d6c60865885257e3f1383a1b1d957483a97ef5c0ff400611f58908f28e',
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
