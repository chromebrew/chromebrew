require 'package'

class Libpstat < Package
  description 'Library for getting information about running processes'
  homepage 'https://github.com/jcnelson/libpstat'
  version '030f37-1'
  compatibility 'all'
  source_url 'https://github.com/jcnelson/libpstat/archive/030f37a9d22ef3b8be839d487c97759e6126c30f.tar.gz'
  source_sha256 '71e5d3f190fe045b38f31dfa9b5962fb6ea4099f46b25981b411122569ff6b30'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libpstat-030f37-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libpstat-030f37-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libpstat-030f37-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libpstat-030f37-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b7fa2a3ee6eb312195bcd50c5f429ea19adde7ecc079afdb2b1b8c505ae208d9',
     armv7l: 'b7fa2a3ee6eb312195bcd50c5f429ea19adde7ecc079afdb2b1b8c505ae208d9',
       i686: '22fa0cda19019be09744d804acab399cba1aa6f8dca14700e45c41a7e2720b05',
     x86_64: 'cdad40a37cc12d312078d4390963f3337260232e1164d5adbca787c9c60f56f5',
  })

  def self.build
    system "sed -i 's,PREFIX ?= /usr/local,PREFIX ?= #{CREW_PREFIX},' Makefile"
    system "sed -i 's,LIBDIR ?= $(DESTDIR)/$(PREFIX)/lib,LIBDIR ?= $(DESTDIR)/#{CREW_LIB_PREFIX},' Makefile"
    system "make -I #{CREW_PREFIX}/include"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
