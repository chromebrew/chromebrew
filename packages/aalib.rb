require 'package'

class Aalib < Package
  description 'AA means Ascii Art - the AAlib (ascii art GFX library), BB (audiovisual demonstration for your terminal), aview (image browser/animation player), AAvga (SVGAlib wrapper for AA-lib), ttyquake (text mode quake), aa3d (random dot stereogram generator)...'
  homepage 'https://sourceforge.net/projects/aa-project/'
  version '1.4p5-50'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://salsa.debian.org/debian/aalib.git'
  git_hashtag "debian/#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/aalib/1.4p5-50_armv7l/aalib-1.4p5-50-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/aalib/1.4p5-50_armv7l/aalib-1.4p5-50-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/aalib/1.4p5-50_i686/aalib-1.4p5-50-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/aalib/1.4p5-50_x86_64/aalib-1.4p5-50-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '6922a2f976e1b20143edc66ae9db0dc7adf7642f00018fdff58abc20a3a1fad5',
     armv7l: '6922a2f976e1b20143edc66ae9db0dc7adf7642f00018fdff58abc20a3a1fad5',
       i686: 'c46022b194d9d561fbc527dd54ff6ce01312f2e8d7d10ae54405616dd6d87a8c',
     x86_64: 'c5817e248feb5caf3b2a3bf47d1fab23d2482646cf3eb13de713ccb99616d367'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libmd' # R
  depends_on 'libx11' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'slang' # R
  depends_on 'xorg_proto' => :build

  def self.patch
    File.foreach 'debian/patches/series' do |patch|
      system "patch -Np1 -i debian/patches/#{patch}" if File.file?(patch)
    end
  end

  def self.build
    system 'autoreconf -fiv'
    system "./configure #{CREW_OPTIONS} \
            --with-x \
            --with-x11-driver \
            --with-slang-driver"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
