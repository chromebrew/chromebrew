require 'package'
 
class Groff < Package
  description 'Groff (GNU troff) is a typesetting system that reads plain text mixed with formatting commands and produces formatted output.'
  homepage 'https://www.gnu.org/software/groff/'
  version '1.22.3-1'
  source_url 'http://ftp.gnu.org/gnu/groff/groff-1.22.3.tar.gz'
  source_sha1 '61a6808ea1ef715df9fa8e9b424e1f6b9fa8c091'
  
  def self.build
    system 'INSTALL_PROGRAM=\'${INSTALL} -s\' ./configure'

    # force to compile in sequential since groff Makefile doesn't work in parallel
    system 'make', '-j1'
  end
  
  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
