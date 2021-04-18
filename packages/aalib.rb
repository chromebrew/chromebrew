require 'package'

class Aalib < Package
  description 'AA means Ascii Art - the AAlib (ascii art GFX library), BB (audiovisual demonstration for your terminal), aview (image browser/animation player), AAvga (SVGAlib wrapper for AA-lib), ttyquake (text mode quake), aa3d (random dot stereogram generator)...'
  homepage 'https://sourceforge.net/projects/aa-project/'
  version '1.4rc5-1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/aa-project/aa-lib/1.4rc5/aalib-1.4rc5.tar.gz'
  source_sha256 'fbddda9230cf6ee2a4f5706b4b11e2190ae45f5eda1f0409dc4f99b35e0a70ee'

  binary_url ({
    aarch64: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/aalib-1.4rc5-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://downloads.sourceforge.net/project/chromebrew/armv7l/aalib-1.4rc5-1-chromeos-armv7l.tar.xz',
       i686: 'https://downloads.sourceforge.net/project/chromebrew/i686/aalib-1.4rc5-1-chromeos-i686.tar.xz',
     x86_64: 'https://downloads.sourceforge.net/project/chromebrew/x86_64/aalib-1.4rc5-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd9db71b403a9492a4bc0ffd82f1993763aeff7625c6607eb53182f4b0bd5e30c',
     armv7l: 'd9db71b403a9492a4bc0ffd82f1993763aeff7625c6607eb53182f4b0bd5e30c',
       i686: '0cdf331cf7c565eac49f23736b1d302ee310f14578c0bb0853c7a7efcce48417',
     x86_64: 'cb93cb013a71eaa178204747526f62c315be01fc910b76ca6e756848cddbab06',
  })

  depends_on 'libx11'
  depends_on 'xorg_proto' => :build

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
            --with-x \
            --with-x11-driver \
            --with-slang-driver"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    FileUtils.mv "#{CREW_DEST_PREFIX}/info/", "#{CREW_DEST_PREFIX}/share/"
  end
end
