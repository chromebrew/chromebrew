require 'package'

class Libuv < Package
  description 'libuv is a multi-platform support library with a focus on asynchronous I/O.'
  homepage 'http://libuv.org/'
  version '1.9.1'
  source_url 'http://dist.libuv.org/dist/v1.9.1/libuv-v1.9.1.tar.gz'
  source_sha1 '668d636372e3276aecc6082082a86f86ddb67877'

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
