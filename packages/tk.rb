require 'package'

class Tk < Package
  description 'Tk is a graphical user interface toolkit that takes developing desktop applications to a higher level than conventional approaches.'
  homepage 'http://www.tcl.tk/'
  version '8.6.9'
  source_url 'https://downloads.sourceforge.net/tcl/tk8.6.9-src.tar.gz'
  source_sha256 'd3f9161e8ba0f107fe8d4df1f6d3a14c30cc3512dfc12a795daa367a27660dac'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/tk-8.6.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/tk-8.6.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/tk-8.6.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/tk-8.6.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '79f0e0905a1809f177b9ab3048168acb45491b58e9460ec1254f307397239b67',
     armv7l: '79f0e0905a1809f177b9ab3048168acb45491b58e9460ec1254f307397239b67',
       i686: '18708ac8f18cde32ef3787ec7a3ce1721a1243dbfb73b231b3b71995afe4d0de',
     x86_64: 'd6e901e0e1f86d87d4f97e88a73380e98fdf73bdec4c27832c4f3feb6af953a9',
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
      system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
      FileUtils.ln_s "#{CREW_PREFIX}/bin/wish8.6", "#{CREW_DEST_PREFIX}/bin/wish"
    end
  end
end
