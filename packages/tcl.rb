require 'package'

class Tcl < Package
  description 'Tcl (Tool Command Language) is a very powerful but easy to learn dynamic programming language, suitable for a very wide range of uses, including web and desktop applications, networking, administration, testing and many more.'
  homepage 'http://www.tcl.tk/'
  version '8.6.10'
  source_url 'https://downloads.sourceforge.net/project/tcl/Tcl/8.6.10/tcl8.6.10-src.tar.gz'
  source_sha256 '5196dbf6638e3df8d5c87b5815c8c2b758496eb6f0e41446596c9a4e638d87ed'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tcl-8.6.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tcl-8.6.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tcl-8.6.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tcl-8.6.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5591a9de473cfbb6102772d0ea4751ea65bf4d069573fc17f35b5e797a7db93c',
     armv7l: '5591a9de473cfbb6102772d0ea4751ea65bf4d069573fc17f35b5e797a7db93c',
       i686: '7dce88880df2dc338d5e2af96537f3ae031aae42865590a896de75b1704fb3aa',
     x86_64: 'b841d095d897d29c491b98660957748af3216942e5bae44ec59a43c24bb608bf',
  })

  def self.build
    FileUtils.chdir('unix') do
      if ARCH == 'x86_64'
        system './configure',
               "--prefix=#{CREW_PREFIX}",
               "--libdir=#{CREW_LIB_PREFIX}",
               "--mandir=#{CREW_PREFIX}/share/man",
               '--enable-64bit'
      else
        system './configure',
               "--prefix=#{CREW_PREFIX}",
               "--libdir=#{CREW_LIB_PREFIX}",
               "--mandir=#{CREW_PREFIX}/share/man",
               '--disable-64bit'
      end
      system 'make'
    end
  end

  def self.install
    FileUtils.chdir('unix') do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-private-headers'
      FileUtils.ln_s "#{CREW_PREFIX}/bin/tclsh8.6", "#{CREW_DEST_PREFIX}/bin/tclsh"
    end
  end
end
