require 'package'

class Libuv < Package
  description 'libuv is a multi-platform support library with a focus on asynchronous I/O.'
  homepage 'http://libuv.org/'
  version '1.9.1'
  source_url 'http://dist.libuv.org/dist/v1.9.1/libuv-v1.9.1.tar.gz'
  source_sha256 'e83953782c916d7822ef0b94e8115ce5756fab5300cca173f0de5f5b0e0ae928'

  depends_on 'glibc'

  def self.build
    system './autogen.sh'
    system './configure --prefix=/usr/local'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
