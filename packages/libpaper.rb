require 'package'

class Libpaper < Package
  description 'Library for handling paper characteristics'
  homepage 'http://packages.debian.org/unstable/source/libpaper'
  version '1.1.28'
  compatibility 'all'
  source_url 'http://ftp.debian.org/debian/pool/main/libp/libpaper/libpaper_1.1.28.tar.gz'
  source_sha256 'c8bb946ec93d3c2c72bbb1d7257e90172a22a44a07a07fb6b802a5bb2c95fddc'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libpaper-1.1.28-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libpaper-1.1.28-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libpaper-1.1.28-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libpaper-1.1.28-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '472aad9c97d57161047736b996d1d1ae3f8baab235ce5f53fc176c74df2edb14',
     armv7l: '472aad9c97d57161047736b996d1d1ae3f8baab235ce5f53fc176c74df2edb14',
       i686: '646d18362de3bcbba53b7f50b49d8d96760083eea17dd1a59fb2de1bc3a84b88',
     x86_64: 'de7927b668b75642bdcfa82b06056af21cb11b9c710453457ecafec690e2880b',
  })

  def self.build
    system 'autoreconf -fi'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
