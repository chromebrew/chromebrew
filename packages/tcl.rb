require 'package'

class Tcl < Package
  description 'Tcl (Tool Command Language) is a very powerful but easy to learn dynamic programming language, suitable for a very wide range of uses, including web and desktop applications, networking, administration, testing and many more.'
  homepage 'http://www.tcl.tk/'
  version '8.6.6' 
  source_url 'http://downloads.sourceforge.net/tcl/tcl8.6.6-src.tar.gz'
  source_sha1 '169dd1589cad62c9fac4257c113db245da502cd0'

  def self.build
    FileUtils.chdir("unix") do
      if `uname -m`.strip == "x86_64"
        system "./configure --prefix=/usr/local --enable-64bit"
      else
	system "./configure --prefix=/usr/local"
      end
      system "make"
    end
  end

  def self.install
    FileUtils.chdir("unix") do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-private-headers"
    end
  end
end
