require 'package'

class Tcsh < Package
  description 'tcsh is a csh compatible shell with file name completion and command line editing.'
  homepage 'https://www.tcsh.org/'
  version '6.22.03'
  compatibility 'all'
  source_url 'https://astron.com/pub/tcsh/tcsh-6.22.03.tar.gz'
  source_sha256 'be2cfd653d2a0c7f506d2dd14c12324ba749bd484037be6df44a3973f52262b7'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
