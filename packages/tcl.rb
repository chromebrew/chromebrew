require 'package'

class Tcl < Package
  description 'Tcl (Tool Command Language) is a very powerful but easy to learn dynamic programming language, suitable for a very wide range of uses, including web and desktop applications, networking, administration, testing and many more.'
  homepage 'http://www.tcl.tk/'
  version '8.6.6'
  source_url 'http://downloads.sourceforge.net/tcl/tcl8.6.6-src.tar.gz'
  source_sha256 'a265409781e4b3edcc4ef822533071b34c3dc6790b893963809b9fe221befe07'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tcl-8.6.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tcl-8.6.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tcl-8.6.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tcl-8.6.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1f7cce2d63b32d0babf41ea2ed0df58946ab61fc675d3b278f0814f09ee1ac23',
     armv7l: '1f7cce2d63b32d0babf41ea2ed0df58946ab61fc675d3b278f0814f09ee1ac23',
       i686: 'baa85fce23a8ff3febfd85f70c6481a13c1485a13325b4601fcbc53277f0247f',
     x86_64: '98aab819039aa52db6a192f5733b0ff7e8ce1cde0bb6b27ea54df23cd7c3cc62',
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
