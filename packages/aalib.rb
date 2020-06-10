require 'package'

class Aalib < Package
  description 'AA means Ascii Art - the AAlib (ascii art GFX library), BB (audiovisual demonstration for your terminal), aview (image browser/animation player), AAvga (SVGAlib wrapper for AA-lib), ttyquake (text mode quake), aa3d (random dot stereogram generator)...'
  homepage 'https://sourceforge.net/projects/aa-project/'
  version '1.4rc5'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/aa-project/aa-lib/1.4rc5/aalib-1.4rc5.tar.gz'
  source_sha256 'fbddda9230cf6ee2a4f5706b4b11e2190ae45f5eda1f0409dc4f99b35e0a70ee'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aalib-1.4rc5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aalib-1.4rc5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aalib-1.4rc5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aalib-1.4rc5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '34ed4e4142bed8a030b93415bda87d682edacb04d70a3a04230571c0f43e9a8c',
     armv7l: '34ed4e4142bed8a030b93415bda87d682edacb04d70a3a04230571c0f43e9a8c',
       i686: '9fafddddfaab739bf91ac769e9d1c6744424a345707f3a18f7c9d6ec3b88ab16',
     x86_64: '9b5fbeb2099e6428eb675fda16077b14ceb4fd22e017a4c041bafe7542bdfe15',
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
