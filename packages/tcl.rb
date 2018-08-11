require 'package'

class Tcl < Package
  description 'Tcl (Tool Command Language) is a very powerful but easy to learn dynamic programming language, suitable for a very wide range of uses, including web and desktop applications, networking, administration, testing and many more.'
  homepage 'http://www.tcl.tk/'
  version '8.6.8'
  source_url 'https://prdownloads.sourceforge.net/tcl/tcl8.6.8-src.tar.gz'
  source_sha256 'c43cb0c1518ce42b00e7c8f6eaddd5195c53a98f94adc717234a65cbcfd3f96a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tcl-8.6.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tcl-8.6.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tcl-8.6.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tcl-8.6.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '343bb68fd5998ca2db9178b0b999e74733ff2254cdee25aa007c178a7759e5d2',
     armv7l: '343bb68fd5998ca2db9178b0b999e74733ff2254cdee25aa007c178a7759e5d2',
       i686: '96d779474cfc036c5f7ff3146e7e688a5010f61dc745ebf5385868fd6c457a59',
     x86_64: 'c87a5444244e428a72baa10f2d8560f22efc3be47ffa9f93121312fdc4939188',
  })

  def self.build
    FileUtils.chdir('unix') do
      if ARCH == 'x86_64'
        system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --enable-64bit"
      else
        system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --disable-64bit"
      end
      system 'make'
    end
  end

  def self.install
    FileUtils.chdir('unix') do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-private-headers"
    end
  end
end
