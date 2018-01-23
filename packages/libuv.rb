require 'package'

class Libuv < Package
  description 'libuv is a multi-platform support library with a focus on asynchronous I/O.'
  homepage 'http://libuv.org/'
  version '1.18.0'
  source_url 'https://dist.libuv.org/dist/v1.18.0/libuv-v1.18.0.tar.gz'
  source_sha256 '54e4734da09172f19d5061dcfd7a536fe4c3a8dc12ed981a14a58ac17efdab88'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libuv-1.18.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libuv-1.18.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libuv-1.18.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libuv-1.18.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8dee95617be290c9fa4292973bd06e20a3167f8ab2e04164e4ae48953022664a',
     armv7l: '8dee95617be290c9fa4292973bd06e20a3167f8ab2e04164e4ae48953022664a',
       i686: '3a5c4b72c075019b940faaec252ad7c632bc93ea3b00a6259488788b27140e38',
     x86_64: '32ab49169ef9aa53b677ea83bf2cb5c1ad343fa962ba096189b2bf4012e17f66',
  })

  depends_on 'automake'
  depends_on 'glibc'
  depends_on 'libtool'

  def self.build
    system './autogen.sh'
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
