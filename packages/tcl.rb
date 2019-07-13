require 'package'

class Tcl < Package
  description 'Tcl (Tool Command Language) is a very powerful but easy to learn dynamic programming language, suitable for a very wide range of uses, including web and desktop applications, networking, administration, testing and many more.'
  homepage 'http://www.tcl.tk/'
  version '8.6.9'
  source_url 'https://prdownloads.sourceforge.net/tcl/tcl8.6.9-src.tar.gz'
  source_sha256 'ad0cd2de2c87b9ba8086b43957a0de3eb2eb565c7159d5f53ccbba3feb915f4e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tcl-8.6.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tcl-8.6.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tcl-8.6.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tcl-8.6.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f798b7dd415d295724f0000d16a585b059b38813f49407c8f50c4eb51b59f537',
     armv7l: 'f798b7dd415d295724f0000d16a585b059b38813f49407c8f50c4eb51b59f537',
       i686: '7b8bc63aa6500c5c3f0e8f9231122bf6634261b1c28fac2328503e44290f685f',
     x86_64: 'd452c8fd5a7907bede90d2d5d32d9483fa6ef34b87b9d1544fa769c0ae7890f6',
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
