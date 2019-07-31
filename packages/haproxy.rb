require 'package'

class Haproxy < Package
  description 'The Reliable, High Performance TCP/HTTP Load Balancer.'
  homepage 'https://www.haproxy.org/'
  version '2.0.3'
  source_url 'https://www.haproxy.org/download/2.0/src/haproxy-2.0.3.tar.gz'
  source_sha256 'aac1ff3e5079997985b6560f46bf265447d0cd841f11c4d77f15942c9fe4b770'

  depends_on 'pcre2'

  def self.build
    system 'make', 'TARGET=linux-glibc', 'USE_OPENSSL=1', 'USE_PCRE2_JIT=1', 'USE_ZLIB=1', 'DEBUG=-s'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
