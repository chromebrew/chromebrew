require 'package'

class Haproxy < Package
  description 'The Reliable, High Performance TCP/HTTP Load Balancer.'
  homepage 'https://www.haproxy.org/'
  version '3.4.1'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.haproxy.org/download/#{version.split('.')[0..1].join('.')}/src/haproxy-#{version}.tar.gz"
  source_sha256 '2e62c4ce4fd77d3bc7cf17e586431663454456a078b7c8465b8f0125b5bc22f8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f809110ff8d2514437ae68053d87719dc03ac93c68352856fb7a5229c44f0190',
     armv7l: 'f809110ff8d2514437ae68053d87719dc03ac93c68352856fb7a5229c44f0190',
     x86_64: '830613af4191eb3f1d32bb080dc1745480f23ecb32b64fa29c701de9576f3cf5'
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
