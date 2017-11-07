require 'package'

class Log4cplus < Package
  description 'log4cplus is a simple to use C++ logging API providing thread-safe, flexible, and arbitrarily granular control over log management and configuration.'
  homepage 'https://sourceforge.net/projects/log4cplus/'
  version '1.2.1-rc2'
  source_url 'https://downloads.sourceforge.net/project/log4cplus/log4cplus-stable/1.2.1/log4cplus-1.2.1-rc2.tar.xz'
  source_sha256 '44119e4406f22007580fd0c9504cf4c4bf1ed365aef42b177c48267aa1a45178'

  def self.build
    system "./configure --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
