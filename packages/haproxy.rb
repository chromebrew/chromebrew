require 'package'

class Haproxy < Package
  description 'The Reliable, High Performance TCP/HTTP Load Balancer.'
  homepage 'https://www.haproxy.org/'
  version '3.4.8'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://www.haproxy.org/download/#{version.split('.')[0..1].join('.')}/src/haproxy-#{version}.tar.gz"
  source_sha256 '024bd521a6cbbe32b426853147e6bbd6a89b107c5a34144846193fee5b7c6ed1'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4f076265ccabba612c0a5bf678153e7868a4bb16e72d978e6630762117c33ecc',
     armv7l: '4f076265ccabba612c0a5bf678153e7868a4bb16e72d978e6630762117c33ecc',
     x86_64: '6e3c6b1a6da0396daaab09941b940685253ed087009eda4d7ec92f659aeb41b4'
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
