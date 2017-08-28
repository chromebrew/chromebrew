require 'package'

class Tcl < Package
  description 'Tcl (Tool Command Language) is a very powerful but easy to learn dynamic programming language, suitable for a very wide range of uses, including web and desktop applications, networking, administration, testing and many more.'
  homepage 'http://www.tcl.tk/'
  version '8.6.7'
  source_url 'http://downloads.sourceforge.net/tcl/tcl8.6.7-src.tar.gz'
  source_sha256 '7c6b8f84e37332423cfe5bae503440d88450da8cc1243496249faa5268026ba5'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tcl-8.6.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tcl-8.6.7-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tcl-8.6.7-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tcl-8.6.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '8e4cda3f545673755249e8b168cb07503a51e6629137cb47c1bebdd707e05947',
     armv7l: '8e4cda3f545673755249e8b168cb07503a51e6629137cb47c1bebdd707e05947',
       i686: '1f20c9bc6a2a5699fd86f78e5b2bfc0535fe9f97fc613bcab5bc3a517fb29d58',
     x86_64: '56fba3820399b6794ed05a5725b25886f3d8b6828c2b8b08bf0245e9b7d4360c',
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
