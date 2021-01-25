require 'package'

class Trousers < Package
  description 'The open-source TCG Software Stack.'
  homepage 'http://trousers.sourceforge.net/'
  @_ver = '0.3.14'
  version @_ver
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/trousers/trousers/#{@_ver}/trousers-#{@_ver}.tar.gz"
  source_sha256 'ce50713a261d14b735ec9ccd97609f0ad5ce69540af560e8c3ce9eb5f2d28f47'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/trousers-0.3.14-1-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/trousers-0.3.14-1-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/trousers-0.3.14-1-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/trousers-0.3.14-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '24985a1b1725983d79858df465e2b25a2c5f60dee41ff70d7f4987602ef13864',
      armv7l: '24985a1b1725983d79858df465e2b25a2c5f60dee41ff70d7f4987602ef13864',
        i686: '80fa9d0426440f6fb1f8cdfbc1a7120ba25a8d3387bb68db4347d0b052b5de4c',
      x86_64: '0650dd02ec6c5219fa959e495e8022032ea4e0a55605dcaec169c6cbd40cae9f',
  })

  depends_on 'openssl'
  depends_on 'libtool'
  depends_on 'pkgconfig'

  def self.build
    system "CFLAGS='-fcommon -flto -pipe' ./configure \
      #{CREW_OPTIONS} \
      --with-gui=none"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
