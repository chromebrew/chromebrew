require 'package'

class Mawk < Package
  description 'mawk is a POSIX compatible interpreter of the awk language faster than gawk.'
  homepage 'https://salsa.debian.org/debian/mawk'
  version '1.3.4'
  compatibility 'all'
  source_url 'https://salsa.debian.org/debian/mawk/-/archive/debian/1.3.4.20200120-2/mawk-debian-1.3.4.20200120-2.tar.bz2'
  source_sha256 '61bd21eb4a62b6e1ff199d4c7cb9f9e1cc882ac24e75ad2dab04e190e87656dc'

  def self.build
    system "./configure \
            #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
