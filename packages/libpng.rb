require 'package'

class Libpng < Package
  description 'libpng is the official PNG reference library.'
  homepage 'http://libpng.org/pub/png/libpng.html'
  version '1.6.37'
  license 'libpng2'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/libpng/libpng16/1.6.37/libpng-1.6.37.tar.xz'
  source_sha256 '505e70834d35383537b6491e7ae8641f1a4bed1876dbfe361201fc80868d88ca'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpng/1.6.37_armv7l/libpng-1.6.37-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpng/1.6.37_armv7l/libpng-1.6.37-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpng/1.6.37_i686/libpng-1.6.37-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libpng/1.6.37_x86_64/libpng-1.6.37-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a38812b2665ff8c46b6f7b1398bc9a77875f3db199e71c5181e5db195063fbbb',
     armv7l: 'a38812b2665ff8c46b6f7b1398bc9a77875f3db199e71c5181e5db195063fbbb',
       i686: '2cc3c4a73a0e33e8d35ea6c9da5443b24cb6f2250475d9cc63016d438968fa4b',
     x86_64: '30be8b66be155cdd233dcc7b638ba2cd173e347165f088c71b1d9dab928cca95'
  })

  depends_on 'zlibpkg'

  def self.patch
    # Fix /usr/bin/file: No such file or directory
    system 'filefix'
  end

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --disable-dependency-tracking \
            --disable-maintainer-mode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
