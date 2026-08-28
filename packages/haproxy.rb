require 'package'

class Haproxy < Package
  description 'The Reliable, High Performance TCP/HTTP Load Balancer.'
  homepage 'https://www.haproxy.org/'
  version '3.4.4'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.haproxy.org/download/#{version.split('.')[0..1].join('.')}/src/haproxy-#{version}.tar.gz"
  source_sha256 'b0c5053c4d46840ecdee3925736fe9a3de6472559b43c69183d70e593d9133df'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '928cefab8703d41691314c3041f5f48e5ec3d35ea0013f1267ad59939c7b2207',
     armv7l: '928cefab8703d41691314c3041f5f48e5ec3d35ea0013f1267ad59939c7b2207',
     x86_64: '44f76c8583e98cb7d7269d1cdef10a16d5a86e6f42ac459120bccbb229451224'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libxcrypt' => :executable
  depends_on 'openssl' => :executable
  depends_on 'pcre2' => :executable
  depends_on 'zlib' => :executable

  no_fhs

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}", 'TARGET=linux-glibc',
           'USE_OPENSSL=1', 'USE_PCRE2_JIT=1', 'USE_ZLIB=1', 'DEBUG=-s'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
