require 'package'

class Scrollz < Package
  description 'ScrollZ is an advanced IRC client based on ircII.'
  homepage 'http://www.scrollz.info/'
  version '2.3-1'
  source_url 'http://www.scrollz.info/download/ScrollZ-2.3.tar.gz'
  source_sha256 '22535bcc54ad752107ab181775d90d9cf1b37648f500d627f428388a9d3710e6'

  depends_on 'buildessential'
  depends_on 'ncurses'

  def self.build
    # Force to disable using termcap since it causes link errors.
    system "CFLAGS=-I/usr/local/include/ncurses ./configure ac_cv_header_termcap_h=no ac_cv_lib_termcap_tgetent=no"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
