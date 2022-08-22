require 'package'

class Aalib < Package
  description 'AA means Ascii Art - the AAlib (ascii art GFX library), BB (audiovisual demonstration for your terminal), aview (image browser/animation player), AAvga (SVGAlib wrapper for AA-lib), ttyquake (text mode quake), aa3d (random dot stereogram generator)...'
  homepage 'https://sourceforge.net/projects/aa-project/'
  version '1.4rc5-1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/aa-project/aa-lib/1.4rc5/aalib-1.4rc5.tar.gz'
  source_sha256 'fbddda9230cf6ee2a4f5706b4b11e2190ae45f5eda1f0409dc4f99b35e0a70ee'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/aalib/1.4rc5-1_armv7l/aalib-1.4rc5-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/aalib/1.4rc5-1_armv7l/aalib-1.4rc5-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/aalib/1.4rc5-1_i686/aalib-1.4rc5-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/aalib/1.4rc5-1_x86_64/aalib-1.4rc5-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '755e06e37eb67e35e25001426a69b6549160aae9262411afbac6435dcd2bc3fb',
     armv7l: '755e06e37eb67e35e25001426a69b6549160aae9262411afbac6435dcd2bc3fb',
       i686: '5c63962cd96ef7a0ac7c364fa58634719857959191548e3853ab2c7bc51aabc9',
     x86_64: '51442b518e9d817078e7bd677667847d363bcf7bc47616331e76b2150ccf28f9'
  })

  depends_on 'libx11'
  depends_on 'xorg_proto' => :build

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
            --with-x \
            --with-x11-driver \
            --with-slang-driver"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mv "#{CREW_DEST_PREFIX}/info/", "#{CREW_DEST_PREFIX}/share/"
  end
end
