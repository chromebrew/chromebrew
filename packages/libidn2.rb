require 'package'

class Libidn2 < Package
  description 'GNU Libidn is a fully documented implementation of the Stringprep, Punycode and IDNA 2003 specifications.'
  homepage 'https://www.gnu.org/software/libidn/'
  @_ver = '2.3.3'
  version "#{@_ver}-1"
  license 'GPL-2+ and LGPL-3+'
  compatibility 'all'
  source_url "https://ftpmirror.gnu.org/libidn/libidn2-#{@_ver}.tar.gz"
  source_sha256 'f3ac987522c00d33d44b323cae424e2cffcb4c63c6aa6cd1376edacbf1c36eb0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.3-1_armv7l/libidn2-2.3.3-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.3-1_armv7l/libidn2-2.3.3-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.3-1_i686/libidn2-2.3.3-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libidn2/2.3.3-1_x86_64/libidn2-2.3.3-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1f1a4300e5141ff670b61c24ce33eea2455801af61916fa325866acd47648a2f',
     armv7l: '1f1a4300e5141ff670b61c24ce33eea2455801af61916fa325866acd47648a2f',
       i686: '4cb850ff4d430533d513e5811b8af44c4081161c9d5c5714e7c1fe7b2f1434d7',
     x86_64: 'ea4b9348c401c8655f0a77fc92149887b26fb7cad7f6ce5628488fa72d8223d6'
  })

  depends_on 'glibc' # R
  depends_on 'libunistring'

  def self.build
    system "mold -run ./configure #{CREW_OPTIONS}"
    system 'mold -run make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
