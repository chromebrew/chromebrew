require 'package'

class Haproxy < Package
  description 'The Reliable, High Performance TCP/HTTP Load Balancer.'
  homepage 'https://www.haproxy.org/'
  version '3.4.7'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.haproxy.org/download/#{version.split('.')[0..1].join('.')}/src/haproxy-#{version}.tar.gz"
  source_sha256 'ccfd342f3724c2cd659574044d788f44e20b212467c6bd5edbbfc517a2775dca'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bf8f490d9ad69c72c6e471544f724540bc4df671dde792773351c04dc764846f',
     armv7l: 'bf8f490d9ad69c72c6e471544f724540bc4df671dde792773351c04dc764846f',
     x86_64: '6af822e469b0f1ee0ef04b74c8c13fee7c40c6774d60a8640b23420e17153c14'
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
