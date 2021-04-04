require 'package'

class Sonic < Package
  description 'Sonic is a simple library to speed up or slow down speech.'
  homepage 'http://dev.vinux-project.org/sonic'
  version '0.2.0'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/espeak-ng/sonic/archive/refs/tags/release-0.2.0.tar.gz'
  source_sha256 'c7827ce576838467590ffa1f935fbe1049e896dfed6c515cf569ad3779c24085'

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
