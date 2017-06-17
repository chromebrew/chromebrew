require 'package'

class Termcap < Package
  description 'A library for sending terminal control codes.'
  homepage 'https://www.gnu.org/software/termutils/'
  version '1.3.1'
  source_url 'https://ftp.gnu.org/gnu/termcap/termcap-1.3.1.tar.gz'
  source_sha1 '42dd1e6beee04f336c884f96314f0c96cc2578be'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
