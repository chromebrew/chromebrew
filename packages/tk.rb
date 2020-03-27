require 'package'

class Tk < Package
  description 'Tk is a graphical user interface toolkit that takes developing desktop applications to a higher level than conventional approaches.'
  homepage 'http://www.tcl.tk/'
  version '8.6.10'
  source_url 'https://downloads.sourceforge.net/project/tcl/Tcl/8.6.10/tk8.6.10-src.tar.gz'
  source_sha256 '63df418a859d0a463347f95ded5cd88a3dd3aaa1ceecaeee362194bc30f3e386'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tk-8.6.10-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tk-8.6.10-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tk-8.6.10-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tk-8.6.10-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6d785178ad707132d9afdec648b992717d48690497da95d3969629b208e38f96',
     armv7l: '6d785178ad707132d9afdec648b992717d48690497da95d3969629b208e38f96',
       i686: '3ec13ce5720f008c8075fa8a6965b4a764f0993d9dadda2aa9268af2a563c400',
     x86_64: 'd75b2657048e3f258826eb8ff1d9d4924021fe7869c41a6ac618a2df7df281ca',
  })

  depends_on 'xorg_lib'
  depends_on 'tcl'

  def self.build
    FileUtils.chdir('unix') do
      if ARCH == 'x86_64'
        system './configure',
               "--prefix=#{CREW_PREFIX}",
               "--libdir=#{CREW_LIB_PREFIX}",
               "--mandir=#{CREW_PREFIX}/share/man",
               "--with-tcl=#{CREW_LIB_PREFIX}",
               '--enable-threads',
               '--enable-64bit'
      else
        system './configure',
               "--prefix=#{CREW_PREFIX}",
               "--libdir=#{CREW_LIB_PREFIX}",
               "--mandir=#{CREW_PREFIX}/share/man",
               "--with-tcl=#{CREW_LIB_PREFIX}",
               '--enable-threads',
               '--disable-64bit'
      end
      system 'make'
    end
  end

  def self.install
    FileUtils.chdir('unix') do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
      FileUtils.ln_s "#{CREW_PREFIX}/bin/wish8.6", "#{CREW_DEST_PREFIX}/bin/wish"
    end
  end
end
