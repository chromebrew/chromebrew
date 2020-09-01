require 'package'

class Mkfontscale < Package
  description 'X11 Scalable Font Index Generator'
  homepage 'https://www.x.org/wiki'
  version '1.2.1'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/app/mkfontscale-1.2.1.tar.bz2'
  source_sha256 'ca0495eb974a179dd742bfa6199d561bda1c8da4a0c5a667f21fd82aaab6bac7'

  depends_on 'xorg_proto'
  depends_on 'zlibpkg'
  depends_on 'freetype'
  depends_on 'libfontenc'

  def self.build
      system "./configure #{CREW_OPTIONS}"
      system "make -j#{CREW_NPROC}"
  end
  def self.install
      system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end