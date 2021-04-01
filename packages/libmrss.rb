require 'package'

class Libmrss < Package
  description 'libmRSS is a C library for parsing, writing and creating RSS files or streams.'
  homepage 'https://www.autistici.org/bakunin/libmrss/doc/'
  version '0.19.2-7'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://salsa.debian.org/debian/libmrss/-/archive/debian/0.19.2-7/libmrss-debian-0.19.2-7.tar.bz2'
  source_sha256 'cc3b466fa376d9fa54644268957437ce525fc336926180fda4e831af019767a6'

  depends_on 'libnxml'

  def self.patch
    system "for i in \$(cat debian/patches/series); do patch -Np1 -i debian/patches/\"\${i}\"; done"
  end

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
