require 'package'

class Haproxy < Package
  description 'The Reliable, High Performance TCP/HTTP Load Balancer.'
  homepage 'https://www.haproxy.org/'
  version '2.0.5'
  source_url 'https://www.haproxy.org/download/2.0/src/haproxy-2.0.5.tar.gz'
  source_sha256 '3f2e0d40af66dd6df1dc2f6055d3de106ba62836d77b4c2e497a82a4bdbc5422'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'pcre2'

  def self.build
    system 'make', 'TARGET=linux-glibc', 'USE_OPENSSL=1', 'USE_PCRE2_JIT=1', 'USE_ZLIB=1', 'DEBUG=-s'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
