require 'package'

class Gnuplot < Package
  description 'Gnuplot is a portable command-line driven graphing utility'
  homepage 'http://gnuplot.sourceforge.net/'
  version '5.2.4'
  source_url 'http://downloads.sourceforge.net/project/gnuplot/gnuplot/5.2.4/gnuplot-5.2.4.tar.gz'
  source_sha256 '1515f000bd373aaa53b16183f274189d4f5e0ae47d22f434857933d16a4770cb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnuplot-5.2.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnuplot-5.2.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnuplot-5.2.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnuplot-5.2.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7f9af59b0427fdd1af077f7d7520f74cf3c146c6d2463f7f35263e89bef2095b',
     armv7l: '7f9af59b0427fdd1af077f7d7520f74cf3c146c6d2463f7f35263e89bef2095b',
       i686: 'be055c10aaedf2813151cf9b0998f77779021510759d5eefc126dbfdb43b1f19',
     x86_64: '59bebf199e3de46e405b1ef27b0037f7a05d59cd97f53fa36e32878a3eb677c7',
  })

  depends_on 'libcerf'
  depends_on 'libxrender'
  depends_on 'libxxf86vm'
  depends_on 'lua'
  depends_on 'pango'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
