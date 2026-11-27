require 'package'

class Haproxy < Package
  description 'The Reliable, High Performance TCP/HTTP Load Balancer.'
  homepage 'https://www.haproxy.org/'
  version '3.4.9'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.haproxy.org/download/#{version.split('.')[0..1].join('.')}/src/haproxy-#{version}.tar.gz"
  source_sha256 '896c55b6029ec2a841617e92a327a335f36a8968e7d51a47eada159673c2f320'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7505cc42c14f1b9bbf10a9cf9463c2e94f289b4e9aac171a5b7b732bddf9737c',
     armv7l: '7505cc42c14f1b9bbf10a9cf9463c2e94f289b4e9aac171a5b7b732bddf9737c',
     x86_64: 'a57a7e405eec87f5a2f8cd7205fe084397166e60905b49fe0a2761f3e184e755'
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
