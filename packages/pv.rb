require 'package'

class Pv < Package
  description 'pv - Pipe Viewer - is a terminal-based tool for monitoring the progress of data through a pipeline.'
  homepage 'http://www.ivarch.com/programs/pv.shtml'
  version '1.6.0'
  source_url 'http://www.ivarch.com/programs/sources/pv-1.6.0.tar.gz'
  source_sha256 '9dd45391806b0ed215abee4c5ac1597d018c386fe9c1f5afd2f6bc3b07fd82c3'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
