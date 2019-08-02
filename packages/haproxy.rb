require 'package'

class Haproxy < Package
  description 'The Reliable, High Performance TCP/HTTP Load Balancer.'
  homepage 'https://www.haproxy.org/'
  version '2.0.3'
  source_url 'https://www.haproxy.org/download/2.0/src/haproxy-2.0.3.tar.gz'
  source_sha256 'aac1ff3e5079997985b6560f46bf265447d0cd841f11c4d77f15942c9fe4b770'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/haproxy-2.0.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/haproxy-2.0.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/haproxy-2.0.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/haproxy-2.0.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'a39b9aed16ef1c7847900c7e4d35deaf7fa3bb704f95a15544db010798b276c0',
     armv7l: 'a39b9aed16ef1c7847900c7e4d35deaf7fa3bb704f95a15544db010798b276c0',
       i686: '44b553dcc063d51b090a51c67c2755a5d6412215cc8c8804348d783fe1195cac',
     x86_64: '4de3e8213ea510996e81039fbd6dd9e5d4b15de6728cded2a0a12763a56d5f2a',
  })

  depends_on 'pcre2'

  def self.build
    system 'make', 'TARGET=linux-glibc', 'USE_OPENSSL=1', 'USE_PCRE2_JIT=1', 'USE_ZLIB=1', 'DEBUG=-s'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
