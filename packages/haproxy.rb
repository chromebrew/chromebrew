require 'package'

class Haproxy < Package
  description 'The Reliable, High Performance TCP/HTTP Load Balancer.'
  homepage 'https://www.haproxy.org/'
  version '3.2.4'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'all'
  source_url "https://www.haproxy.org/download/#{version.split('.')[0..1].join('.')}/src/haproxy-#{version}.tar.gz"
  source_sha256 '624f911f80a6aaf047d3bedc51bd2d282fd31bf664fa205b1f447a537a055c1d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '622d3a99622c5c10960ea2e670556f428a1e5290b1c984ce03329f4206143245',
     armv7l: '622d3a99622c5c10960ea2e670556f428a1e5290b1c984ce03329f4206143245',
       i686: '2e21699bc8884afc6991d02bd43caa094b821ce0d57c338dd63af8508831293c',
     x86_64: 'f0057eab7bd92c0bd51277f42e92a32e4447ce0d1288e6d73c8d8f3b6fc05c52'
  })

  depends_on 'glibc' # R
  depends_on 'zlib' # R

  no_fhs

  def self.build
    system 'make', 'TARGET=linux-glibc', 'USE_OPENSSL=1', 'USE_PCRE2_JIT=1', 'USE_ZLIB=1', 'DEBUG=-s'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
