require 'package'

class Tcl < Package
  description 'Tcl (Tool Command Language) is a very powerful but easy to learn dynamic programming language, suitable for a very wide range of uses, including web and desktop applications, networking, administration, testing and many more.'
  homepage 'http://www.tcl.tk/'
  version '8.6.10-1'
  source_url 'https://downloads.sourceforge.net/project/tcl/Tcl/8.6.10/tcl8.6.10-src.tar.gz'
  source_sha256 '5196dbf6638e3df8d5c87b5815c8c2b758496eb6f0e41446596c9a4e638d87ed'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tcl-8.6.10-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tcl-8.6.10-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tcl-8.6.10-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tcl-8.6.10-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0e41b09a26a2213ca6cab5ce257a591e067c005c980c0781511d52af1caca117',
     armv7l: '0e41b09a26a2213ca6cab5ce257a591e067c005c980c0781511d52af1caca117',
       i686: '7ba00dfdf973d0cef0b32f73e1a6f29856836b523ff7de021e598db3a2ab4127',
     x86_64: '83c4b53eedb3ea5c7497884749ef7492c5bd547cf32c2afad0f76250d0c8c410',
  })

  def self.build
    FileUtils.chdir('unix') do
      if ARCH == 'x86_64'
        system "./configure #{CREW_OPTIONS} --enable-64bit"
      else
        system "./configure #{CREW_OPTIONS} --disable-64bit"
      end
      system 'make'
    end
  end

  def self.install
    FileUtils.chdir('unix') do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-private-headers'
      FileUtils.ln_s "#{CREW_PREFIX}/bin/tclsh8.6", "#{CREW_DEST_PREFIX}/bin/tclsh"
      FileUtils.ln_s "#{CREW_LIB_PREFIX}/itcl4.2.0/libitcl4.2.0.so", "#{CREW_DEST_LIB_PREFIX}/libitcl4.2.0.so"
      FileUtils.ln_s "#{CREW_LIB_PREFIX}/tdbc1.1.1/libtdbc1.1.1.so", "#{CREW_DEST_LIB_PREFIX}/libtdbc1.1.1.so"
      FileUtils.ln_s "#{CREW_LIB_PREFIX}/thread2.8.5/libthread2.8.5.so", "#{CREW_DEST_LIB_PREFIX}/libthread2.8.5.so"
      FileUtils.ln_s "#{CREW_LIB_PREFIX}/tdbcodbc1.1.1/libtdbcodbc1.1.1.so", "#{CREW_DEST_LIB_PREFIX}/libtdbcodbc1.1.1.so"
      FileUtils.ln_s "#{CREW_LIB_PREFIX}/sqlite3.30.1.2/libsqlite3.30.1.2.so", "#{CREW_DEST_LIB_PREFIX}/libsqlite3.30.1.2.so"
      FileUtils.ln_s "#{CREW_LIB_PREFIX}/tdbcmysql1.1.1/libtdbcmysql1.1.1.so", "#{CREW_DEST_LIB_PREFIX}/libtdbcmysql1.1.1.so"
      FileUtils.ln_s "#{CREW_LIB_PREFIX}/tdbcpostgres1.1.1/libtdbcpostgres1.1.1.so", "#{CREW_DEST_LIB_PREFIX}/libtdbcpostgres1.1.1.so"
    end
  end
end
