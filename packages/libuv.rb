require 'package'

class Libuv < Package
  description 'libuv is a multi-platform support library with a focus on asynchronous I/O.'
  homepage 'http://libuv.org/'
  version '1.15.0'
  source_url 'https://dist.libuv.org/dist/v1.15.0/libuv-v1.15.0.tar.gz'
  source_sha256 '28b1b334ae79fdbb025c7a4dacf3cb14738f9d336998bc42bbdbe72b8799fe85'

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
