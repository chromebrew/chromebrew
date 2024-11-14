require 'package'

class Sonic < Package
  description 'Sonic is a simple library to speed up or slow down speech.'
  homepage 'http://dev.vinux-project.org/sonic'
  version '0.2.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/espeak-ng/sonic/archive/refs/tags/release-0.2.0.tar.gz'
  source_sha256 'c7827ce576838467590ffa1f935fbe1049e896dfed6c515cf569ad3779c24085'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '14ff70ffe97368d3f5297229da2eb228ea1f298c0d35611462957a3ac67a4a79',
     armv7l: '14ff70ffe97368d3f5297229da2eb228ea1f298c0d35611462957a3ac67a4a79',
       i686: '29507c870b513065668973a6f01d5d776012239b16a97437542b5a0f85f10c93',
     x86_64: '1e9bc15ad961fcd5fd606ebc3e21ad3e76a911907cc0293447c357aee1da88f4'
  })

  def self.patch
    system "sed -i 's:CFLAGS=-Wall:CFLAGS=-Wall -pipe -flto=auto -fuse-ld=gold:g' Makefile"
    system "sed -i 's:PREFIX=/usr:PREFIX=#{CREW_PREFIX}:' Makefile"
    system "sed -i 's:LIBDIR=$(PREFIX}/lib:#{CREW_LIB_PREFIX}:' Makefile"
  end

  def self.build
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
