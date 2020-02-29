require 'package'

class Alpine < Package                 # The first character of the class name must be upper case
  description 'The continuation of the Alpine email client from University of Washington.'
  homepage 'http://alpine.x10host.com/alpine'
  version '2.22'
  source_url 'http://alpine.x10host.com/alpine/release/src/alpine-2.22.tar.xz'
  source_sha256 '849567c1b6f71fde3aaa1c97cf0577b12a525d9e22c0ea47797c4bf1cd2bbfdb'   # Use the command "sha256sum"

  def self.build                   # the steps required to build the package
    system "./configure",
    "--prefix=#{CREW_PREFIX}",
    "--libdir=#{CREW_LIB_PREFIX}",
    "--with-ssl-dir=/etc/ssl",
    "--with-ssl-include-dir=/usr/local/include",
    "--with-ssl-lib-dir=#{CREW_LIB_PREFIX}", "--disable-nls",
    "--with-system-pinerc=#{CREW_PREFIX}/etc/alpine.d/pine.conf",
    "--with-system-fixed-pinerc=#{CREW_PREFIX}/etc/alpine/pine.conf.fixed"
    system "make"
  end

  def self.install                 # the steps required to install the package
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check                   # the steps required to check if the package was built ok
    system "make", "check"
  end
end
