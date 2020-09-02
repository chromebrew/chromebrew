require 'package'

class Mkfontscale < Package
  description 'X11 Scalable Font Index Generator'
  homepage 'https://www.x.org/wiki'
  version '1.2.1'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/app/mkfontscale-1.2.1.tar.bz2'
  source_sha256 'ca0495eb974a179dd742bfa6199d561bda1c8da4a0c5a667f21fd82aaab6bac7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mkfontscale-1.2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mkfontscale-1.2.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mkfontscale-1.2.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mkfontscale-1.2.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f2f749976b0fa50fc49d135c7a245ba37f9756b4280b52c756fa07e9a63f03cb',
     armv7l: 'f2f749976b0fa50fc49d135c7a245ba37f9756b4280b52c756fa07e9a63f03cb',
       i686: '3fc8fd6cf76dd72c13cff42c44bafe20c005e6865501128050b6243f1ea26499',
     x86_64: 'e09eb5e4af8b9bd31cd3cbddfa806f5a1e11fd80d297527aec804047b1cef1ec',
  })

  depends_on 'xorg_proto'
  depends_on 'zlibpkg'
  depends_on 'freetype'
  depends_on 'libfontenc'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
