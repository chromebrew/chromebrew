require 'package'

class Rfkill < Package
  description 'Tool for enabling and disabling wireless devices.'
  homepage 'http://linuxwireless.org/en/users/Documentation/rfkill'
  version '1.0'
  license 'ISC'
  compatibility 'all'
  source_url 'https://www.kernel.org/pub/software/network/rfkill/rfkill-1.0.tar.xz'
  source_sha256 'dffc631c611520478b8a286f57c67a35e8cb5802d376c6ca13b057365432389c'

  def self.build
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "SBINDIR=#{CREW_PREFIX}/sbin", "MANDIR=#{CREW_PREFIX}/share/man", "install"
    # Manpage is automatically gzipped. Chromebrew double-gzips it when packaging.
    system "gunzip #{CREW_DEST_MAN_PREFIX}/man8/rfkill.8.gz"
  end

  def self.check
    system "make check"
  end
end
