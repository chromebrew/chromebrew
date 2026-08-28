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
    aarch64: '8c8d8ca0ffe4f7c10aabdadea512195095e99fbb6665b9abd1118e26c0fbfb42',
     armv7l: '8c8d8ca0ffe4f7c10aabdadea512195095e99fbb6665b9abd1118e26c0fbfb42',
     x86_64: 'ada691949eb814d185d0324fef2c28f52723df9a04e3f4616b775fabd70c333e'
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
