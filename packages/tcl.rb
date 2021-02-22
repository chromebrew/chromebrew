require 'package'

class Tcl < Package
  description 'Tcl (Tool Command Language) is a very powerful but easy to learn dynamic programming language, suitable for a very wide range of uses, including web and desktop applications, networking, administration, testing and many more.'
  homepage 'http://www.tcl.tk/'
  @_ver = '8.6.11'
  version @_ver
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/tcl/Tcl/#{@_ver}/tcl#{@_ver}-src.tar.gz"
  source_sha256 '8c0486668586672c5693d7d95817cb05a18c5ecca2f40e2836b9578064088258'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tcl-8.6.11-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tcl-8.6.11-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tcl-8.6.11-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tcl-8.6.11-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'd1a9f91c71af31f9c862ae92836a9ec4c84c9d0213c1ce85d996a69213e1be7c',
     armv7l: 'd1a9f91c71af31f9c862ae92836a9ec4c84c9d0213c1ce85d996a69213e1be7c',
       i686: '6581a445fa9c0a57b66bd4f32cac09f6b9e3a002b377e97163cfba10ff73f230',
     x86_64: '502238e6785c264e145b19fec1267104a839ecd4ab6cce9e21802810c601e591'
  })

  # tk breaks if tcl is built with lto
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
      FileUtils.ln_s "#{CREW_LIB_PREFIX}/tdbcodbc1.1.1/libtdbcodbc1.1.1.so",
                     "#{CREW_DEST_LIB_PREFIX}/libtdbcodbc1.1.1.so"
      FileUtils.ln_s "#{CREW_LIB_PREFIX}/sqlite3.30.1.2/libsqlite3.30.1.2.so",
                     "#{CREW_DEST_LIB_PREFIX}/libsqlite3.30.1.2.so"
      FileUtils.ln_s "#{CREW_LIB_PREFIX}/tdbcmysql1.1.1/libtdbcmysql1.1.1.so",
                     "#{CREW_DEST_LIB_PREFIX}/libtdbcmysql1.1.1.so"
      FileUtils.ln_s "#{CREW_LIB_PREFIX}/tdbcpostgres1.1.1/libtdbcpostgres1.1.1.so",
                     "#{CREW_DEST_LIB_PREFIX}/libtdbcpostgres1.1.1.so"
    end
  end
end
