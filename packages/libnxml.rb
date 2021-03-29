require 'package'

class Libnxml < Package
  description 'libmRSS is a C library for parsing, writing and creating RSS files or streams.'
  homepage 'https://www.autistici.org/bakunin/libnxml/doc/'
  version '2.1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://salsa.debian.org/debian/libnxml/-/archive/debian/0.18.3-8/libnxml-debian-0.18.3-8.tar.bz2'
  source_sha256 '2c3e910b591d8f2a4dde53874339ddf831cfcce4cfece429217b5a5b9f850a9d'
  
  def self.patch
    system "for i in $(cat debian/patches/series); do patch -Np1 -i debian/patches/${i}; done"
  end
  
  def self.prebuild
    system "chmod +x ./configure"
  end
  
  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end
  
  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
