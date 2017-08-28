require 'package'

class Tcl < Package
  description 'Tcl (Tool Command Language) is a very powerful but easy to learn dynamic programming language, suitable for a very wide range of uses, including web and desktop applications, networking, administration, testing and many more.'
  homepage 'http://www.tcl.tk/'
  version '8.6.7'
  source_url 'http://downloads.sourceforge.net/tcl/tcl8.6.7-src.tar.gz'
  source_sha256 '7c6b8f84e37332423cfe5bae503440d88450da8cc1243496249faa5268026ba5'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    FileUtils.chdir("unix") do
      if `uname -m`.strip == "x86_64"
        system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --enable-64bit"
      else
        system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
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
