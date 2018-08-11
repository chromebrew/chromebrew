require 'package'

class Tk < Package
  description 'Tk is a graphical user interface toolkit that takes developing desktop applications to a higher level than conventional approaches.'
  homepage 'http://www.tcl.tk/'
  version '8.6.8'
  source_url 'https://prdownloads.sourceforge.net/tcl/tk8.6.8-src.tar.gz'
  source_sha256 '49e7bca08dde95195a27f594f7c850b088be357a7c7096e44e1158c7a5fd7b33'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tk-8.6.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tk-8.6.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tk-8.6.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tk-8.6.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0c12b3457d4a6ea994c11b659d9e88058de96bdc1202eaed31db1e1975d0e871',
     armv7l: '0c12b3457d4a6ea994c11b659d9e88058de96bdc1202eaed31db1e1975d0e871',
       i686: '854b3f056b6f1b85f2ab65cd2fbed9d568bef018cdc9d887ec157467f3835f51',
     x86_64: '0d036e369efa5c3199ebeaf9ae71e5dea15b982fa3d885fbb6b8dcd19cfdf3e3',
  })

  depends_on 'tcl'

  def self.build
    FileUtils.chdir('unix') do
      if ARCH == 'x86_64'
        system './configure',
               "--prefix=#{CREW_PREFIX}",
               "--libdir=#{CREW_LIB_PREFIX}",
               "--with-tcl=#{CREW_LIB_PREFIX}",
               '--enable-threads',
               '--enable-64bit'
      else
        system './configure',
               "--prefix=#{CREW_PREFIX}",
               "--libdir=#{CREW_LIB_PREFIX}",
               "--with-tcl=#{CREW_LIB_PREFIX}",
               '--enable-threads',
               '--disable-64bit'
      end
      system 'make'
    end
  end

  def self.install
    FileUtils.chdir('unix') do
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    end
  end
end
