require 'package'

class Libiconv < Package
  description 'GNU charset conversion library for libc which does not implement it.'
  homepage 'https://www.gnu.org/software/libiconv/'
  version '1.16-2'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/libiconv/libiconv-1.16.tar.gz'
  source_sha256 'e6a1b1b589654277ee790cce3734f07876ac4ccfaecbee8afa0b649cf529cc04'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libiconv-1.16-2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '83ebdeb7420ca8b5b52cb92b0367d708dc1bbcdf08acc6044004b474b2b7e606',
     armv7l: '83ebdeb7420ca8b5b52cb92b0367d708dc1bbcdf08acc6044004b474b2b7e606',
       i686: 'd239e42841b7bcea1669e0389cecbe01a23a5e1249623f90101cf9ff5861086f',
     x86_64: '6a344f234625a49d73b0ed8d3e3633c41186c78390ea1342081ded649fcc8dea',
  })

  def self.build
    system "./configure #{CREW_OPTIONS} --enable-static --enable-relocatable --enable-extra-encodings"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
