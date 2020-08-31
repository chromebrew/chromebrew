require 'package'

class Libhandy < Package
  description 'The aim of the handy library is to help with developing UI for mobile devices using GTK/GNOME.'
  homepage 'https://gitlab.gnome.org/GNOME/libhandy/'
  version '0.90.0'
  compatibility 'all'
  source_url 'https://gitlab.gnome.org/GNOME/libhandy/-/archive/0.90.0/libhandy-0.90.0.tar.bz2'
  source_sha256 '24f015851cb5ac20c8ae9c88303229f91af84e9f1652904e15ebd3a94c51b4f6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libhandy-0.90.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libhandy-0.90.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libhandy-0.90.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libhandy-0.90.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9a2965bdc5300e83f56ec47e5665bdb1ba62317eeb3c424ad2229468c7452d95',
     armv7l: '9a2965bdc5300e83f56ec47e5665bdb1ba62317eeb3c424ad2229468c7452d95',
       i686: 'b9d0422c882c1d486eb75887fadd32c4aaa7d593f091304539cdcab9d479bf83',
     x86_64: '26d17e23a965f52c549216abd010140f4f4e213f8aa86efb5f0962cf3ce4c429',
  })

  def self.prebuild
    system "sed -i 's,-fstack-protector-strong,-fno-stack-protector,' meson.build"
  end

  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --buildtype=release _build"
    system 'ninja -v -C _build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
  end
end
