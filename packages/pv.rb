require 'package'

class Pv < Package
  description 'pv - Pipe Viewer - is a terminal-based tool for monitoring the progress of data through a pipeline.'
  homepage 'http://www.ivarch.com/programs/pv.shtml'
  version '1.6.6'
  source_url 'http://www.ivarch.com/programs/sources/pv-1.6.6.tar.gz'
  source_sha256 '94defb4183ae07c44219ba298d43c4991d6e203c29f74393d72ecad3b090508a'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
