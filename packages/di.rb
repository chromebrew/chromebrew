require 'package'

class Di < Package
  version '4.43'
  source_url 'http://gentoo.com/di/di-4.43.tar.gz'
  source_sha1 'ddced0d59d29ccdcbc4282bc7464a925d14955e1'

  def self.build
    system "CC=gcc prefix=/usr/local make -e"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "-e", "install"
  end
end
