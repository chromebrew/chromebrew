require 'package'

class Haproxy < Package
  description 'The Reliable, High Performance TCP/HTTP Load Balancer.'
  homepage 'https://www.haproxy.org/'
  version '3.4.2'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.haproxy.org/download/#{version.split('.')[0..1].join('.')}/src/haproxy-#{version}.tar.gz"
  source_sha256 'b1330dbb0d6e6bc4a72c4708a6a9e585579cd1156dfe5763c26305105bc12907'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c77a2e64a1e3fb4c928787fd0951d4d7f551690020eedbc7820076ccd4cd8b03',
     armv7l: 'c77a2e64a1e3fb4c928787fd0951d4d7f551690020eedbc7820076ccd4cd8b03',
     x86_64: 'c6c1923bddd63b16e0f828a59856dc34e07d0313cccb5256dad7a03eeb0beb86'
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
