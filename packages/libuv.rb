require 'package'

class Libuv < Package
  description 'libuv is a multi-platform support library with a focus on asynchronous I/O.'
  homepage 'http://libuv.org/'
  version '1.18.0'
  source_url 'https://dist.libuv.org/dist/v1.18.0/libuv-v1.18.0.tar.gz'
  source_sha256 '54e4734da09172f19d5061dcfd7a536fe4c3a8dc12ed981a14a58ac17efdab88'

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
