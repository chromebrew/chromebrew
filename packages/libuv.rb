require 'package'

class Libuv < Package
  description 'libuv is a multi-platform support library with a focus on asynchronous I/O.'
  homepage 'http://libuv.org/'
  version '1.14.1'
  source_url 'https://dist.libuv.org/dist/v1.14.1/libuv-v1.14.1.tar.gz'
  source_sha256 'f32243d2ad8eb7604cdfff8f719353bbcc4ebbc41def78930569372d7f257d22'

  binary_url ({
  })
  binary_sha256 ({
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
