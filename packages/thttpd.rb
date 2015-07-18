require 'package'

class Thttpd < Package
  version '2.25'
  source_url 'https://www.dropbox.com/s/sckekosjqtde5rt/thttpd-2.25b.tar.gz?dl=0'
  source_sha1 '5c2d37ad4291e262b33588375810deb1d48a37ed'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
