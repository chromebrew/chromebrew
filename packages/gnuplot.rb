require 'package'

class Gnuplot < Package
  description 'Gnuplot is a portable command-line driven graphing utility'
  homepage 'http://gnuplot.sourceforge.net/'
  version '5.2.6'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/gnuplot/gnuplot/5.2.6/gnuplot-5.2.6.tar.gz'
  source_sha256 '35dd8f013139e31b3028fac280ee12d4b1346d9bb5c501586d1b5a04ae7a94ee'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gnuplot-5.2.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gnuplot-5.2.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gnuplot-5.2.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gnuplot-5.2.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '52d2a8b203fff954f4304294cb51c41d26d65fb071f13bb6020be7ca767028f9',
     armv7l: '52d2a8b203fff954f4304294cb51c41d26d65fb071f13bb6020be7ca767028f9',
       i686: '9c635ed8cd0386c877f9bc8801e709a2825730614f71c3b397217c13ed8a9bd8',
     x86_64: '13dec5a3289609f06c963ce97dfe5157c34fd816e71842806401e6d9727cc7b0',
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
