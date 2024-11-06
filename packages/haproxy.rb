require 'package'

class Haproxy < Package
  description 'The Reliable, High Performance TCP/HTTP Load Balancer.'
  homepage 'https://www.haproxy.org/'
  version '3.0.3'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url "https://www.haproxy.org/download/3.0/src/haproxy-#{version}.tar.gz"
  source_sha256 '39a73c187a0b00d2602cb3ffca52d1b59d90f09032734fe8c03eb2e29a7d19df'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8a03a8b27b150300a1e07ea04ea2816a229e65c79d31eb8fe98b3dbe8ca40c5f',
     armv7l: '8a03a8b27b150300a1e07ea04ea2816a229e65c79d31eb8fe98b3dbe8ca40c5f',
       i686: '452b2779e5f74ff7187ec16cfe148db855489df9db5ed65e81cd44435544d9a4',
     x86_64: 'dc66ae60730d8eeaefbadad6a0a0c949d650e1f3b76e9a81f8526aabb020492b'
  })

  depends_on 'pcre2'

  no_fhs

  def self.build
    system 'make', 'TARGET=linux-glibc', 'USE_OPENSSL=1', 'USE_PCRE2_JIT=1', 'USE_ZLIB=1', 'DEBUG=-s'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
