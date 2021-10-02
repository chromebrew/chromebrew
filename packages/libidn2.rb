require 'package'

class Libidn2 < Package
  description 'GNU Libidn is a fully documented implementation of the Stringprep, Punycode and IDNA 2003 specifications.'
  homepage 'https://www.gnu.org/software/libidn/'
  @_ver = '2.3.2'
  version @_ver
  license 'GPL-2+ and LGPL-3+'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/libidn/libidn2-#{@_ver}.tar.gz"
  source_sha256 '76940cd4e778e8093579a9d195b25fff5e936e9dc6242068528b437a76764f91'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.2_armv7l/libidn2-2.3.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.2_armv7l/libidn2-2.3.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.2_i686/libidn2-2.3.2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.2_x86_64/libidn2-2.3.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '6c335d7c611cc1d054c22d2b658aaa060a7bfd682528bac46dc404ffff14c818',
     armv7l: '6c335d7c611cc1d054c22d2b658aaa060a7bfd682528bac46dc404ffff14c818',
       i686: '7ce581270eeba81b5f3ec0d7f0e7826b95248a54e960608cc72777beb9f31098',
     x86_64: '740ae2266e95b4d1974b80165967ec15efd0a7810a649fd7408bdb2964f06de7'
  })

  def self.build
    system "env #{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
