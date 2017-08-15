require 'package'

class Nettle < Package
  description 'Nettle is a cryptographic library that is designed to fit easily in more or less any context: In crypto toolkits for object-oriented languages (C++, Python, Pike, ...), in applications like LSH or GNUPG, or even in kernel space.'
  homepage 'http://www.lysator.liu.se/~nisse/nettle/'
  version '3.3'
  source_url 'https://ftp.gnu.org/gnu/nettle/nettle-3.3.tar.gz'
  source_sha256 '46942627d5d0ca11720fec18d81fc38f7ef837ea4197c1f630e71ce0d470b11e'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/nettle-3.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/nettle-3.3-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/nettle-3.3-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/nettle-3.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd6d0a4768a6e5642fd1817c16bbd56c38075f9094354dd47a92cb61e2d091791',
     armv7l: 'd6d0a4768a6e5642fd1817c16bbd56c38075f9094354dd47a92cb61e2d091791',
       i686: 'c4df887ade348014dea7134e5e8617ffb65fd31c3b0143f0be21e0760a20d62c',
     x86_64: '015e142b98b101f4069f08a78462672984f9d0190edd6c76d3d552c8c0b89bd0',
  })

  depends_on 'buildessential'
  depends_on 'm4'
  depends_on 'openssl'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
