require 'package'

class Rfkill < Package
  description 'Tool for enabling and disabling wireless devices.'
  homepage 'http://linuxwireless.org/en/users/Documentation/rfkill'
  version '0.5'
  source_url 'https://www.kernel.org/pub/software/network/rfkill/rfkill-0.5.tar.xz'
  source_sha1 '03025d4ae285c40d5c19ec99ef7b317afda9d900'

  depends_on 'buildessential' => :build

  def self.build
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "SBINDIR=/usr/local/sbin", "MANDIR=/usr/local/share/man", "install"
  end

  def self.check
    system "make check"
  end
end
