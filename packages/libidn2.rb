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
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
