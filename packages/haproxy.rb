require 'package'

class Haproxy < Package
  description 'The Reliable, High Performance TCP/HTTP Load Balancer.'
  homepage 'https://www.haproxy.org/'
  version '2.0.5'
  compatibility 'all'
  source_url 'https://www.haproxy.org/download/2.0/src/haproxy-2.0.5.tar.gz'
  source_sha256 '3f2e0d40af66dd6df1dc2f6055d3de106ba62836d77b4c2e497a82a4bdbc5422'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/haproxy-2.0.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/haproxy-2.0.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/haproxy-2.0.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/haproxy-2.0.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9c3580edbfa83b4f0d59aa2f6d08689a76fef634daea6bf351a8b022110a5f29',
     armv7l: '9c3580edbfa83b4f0d59aa2f6d08689a76fef634daea6bf351a8b022110a5f29',
       i686: 'a1c749e70a2f3a7e2c76fe52bd2fe72218532d5d20ee018c34fee0a94956f05c',
     x86_64: '06a3eb45445289c84a91ebc03d8f5650c8cd9c8b6988cef8fa49594427d73358',
  })

  depends_on 'pcre2'

  def self.build
    system 'make', 'TARGET=linux-glibc', 'USE_OPENSSL=1', 'USE_PCRE2_JIT=1', 'USE_ZLIB=1', 'DEBUG=-s'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
