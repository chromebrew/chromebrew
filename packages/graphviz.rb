require 'package'

class Graphviz < Package
  description 'Graphviz is open source graph visualization software.'
  homepage 'https://www.graphviz.org/'
  version '2.40.1'
  source_url 'https://gitlab.com/graphviz/graphviz/repository/67cd2e5121379a38e0801cc05cce5033f8a2a609/archive.tar.bz2'
  source_sha256 '8dddc80b4194b17c1a5bc1cc7b5e001e9a3ec27272287dc16f278c736a29a9b9'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/graphviz-2.40.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/graphviz-2.40.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/graphviz-2.40.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/graphviz-2.40.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd1620cf88f88aca31001a64a26c95d02d5ee3b7109b093ea824f381f54d71ed0',
     armv7l: 'd1620cf88f88aca31001a64a26c95d02d5ee3b7109b093ea824f381f54d71ed0',
       i686: 'cb31be3ee6e1d74917c87ebb7a2bb2290e2a1cf1d60ef817b06a5d569b3fdcd3',
     x86_64: 'd27c0177f7c154aacf6c69cbe0ae85c9a36a0aa2946fe32d5f4c9fd39772ce5a',
  })

  depends_on 'automake' => :build
  depends_on 'pango'
  depends_on 'flex'
  depends_on 'gdk_pixbuf'
  depends_on 'libxrender'
  depends_on 'poppler'

  def self.build
    system "./autogen.sh"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
