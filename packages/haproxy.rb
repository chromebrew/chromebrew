require 'package'

class Haproxy < Package
  description 'The Reliable, High Performance TCP/HTTP Load Balancer.'
  homepage 'https://www.haproxy.org/'
  version '3.4.5'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.haproxy.org/download/#{version.split('.')[0..1].join('.')}/src/haproxy-#{version}.tar.gz"
  source_sha256 'ec5095095bce7db2e0e6e971f616dded1bb505717e692ec6c3cc8dab6a31678a'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e09a44884182ba5187b64d6d6a470c493325514c7d059762a878c838c1a84744',
     armv7l: 'e09a44884182ba5187b64d6d6a470c493325514c7d059762a878c838c1a84744',
     x86_64: '6c0bd26109f1e99c55cb3b4dd1c09ed4b5975616b82edeec07c2bea60f6f0f59'
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
