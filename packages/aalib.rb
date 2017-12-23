require 'package'

class Aalib < Package
  description 'AA means Ascii Art - the AAlib (ascii art GFX library), BB (audiovisual demonstration for your terminal), aview (image browser/animation player), AAvga (SVGAlib wrapper for AA-lib), ttyquake (text mode quake), aa3d (random dot stereogram generator)...'
  homepage 'https://sourceforge.net/projects/aa-project/'
  version '1.4rc5'
  source_url 'https://downloads.sourceforge.net/project/aa-project/aa-lib/1.4rc5/aalib-1.4rc5.tar.gz'
  source_sha256 'fbddda9230cf6ee2a4f5706b4b11e2190ae45f5eda1f0409dc4f99b35e0a70ee'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--without-x'
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
