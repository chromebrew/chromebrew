require 'package'

class Unrar < Package
  version '5.4.5'
  source_url 'http://www.rarlab.com/rar/unrarsrc-5.4.5.tar.gz'
  source_sha1 '1590aec535792def68710dad7b73d5522e50c971'

  def self.build
    system "sed -i '145s,$,/libunrar.so,' makefile" # fix naming mistake
    system "sed -i '145s,install,install -D,' makefile" # create directory
    system "make", "all"
    system "make", "lib"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}/usr/local", "install"
    system "make", "DESTDIR=#{CREW_DEST_DIR}/usr/local", "install-lib"
  end
end
