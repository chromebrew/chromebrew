require 'package'

class Figlet < Package
  description 'FIGlet is a program for making large letters out of ordinary text.'
  homepage 'http://www.figlet.org/'
  version '2.2.5'
  source_url 'ftp://ftp.figlet.org/pub/figlet/program/unix/figlet-2.2.5.tar.gz'
  source_sha1 'dda696958c161bd71d6590152c94c4f705415727'

  def self.build
    system "make", "PREFIX=/usr/local"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install" 
  end
end
