require 'package'

class Rfkill < Package
  description 'Tool for enabling and disabling wireless devices.'
  homepage 'http://linuxwireless.org/en/users/Documentation/rfkill'
  version '0.5'
  source_url 'https://www.kernel.org/pub/software/network/rfkill/rfkill-0.5.tar.xz'
  source_sha256 'e0ae3004215e39a6c5c36e0726558740728d16f67ebdb8bea621250f6091d86a'

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
