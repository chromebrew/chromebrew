require 'package'

class Bdftopcf < Package
  description 'BDF to PCF font converter for X11'
  homepage 'https://xorg.freedesktop.org/'
  version '1.1'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/app/bdftopcf-1.1.tar.bz2'
  source_sha256 '4b4df05fc53f1e98993638d6f7e178d95b31745c4568cee407e167491fd311a2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/bdftopcf-1.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/bdftopcf-1.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/bdftopcf-1.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/bdftopcf-1.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cb194dc01e182cdb430c3672d2ac0c7dc83f6091cf2b29e7765ad5b75511074a',
     armv7l: 'cb194dc01e182cdb430c3672d2ac0c7dc83f6091cf2b29e7765ad5b75511074a',
       i686: '25b92f357e56380778d12cc2dcf25585ad99f01c8bedd1fc7b2d81ef089e70ee',
     x86_64: 'b01c0ae817a810ddc1523a2b9fe97c0efcc45b6301aa84c1cf3618020cbdb80b',
  })

  depends_on 'libxfont'

  def self.build
      system "./configure #{CREW_OPTIONS} "
      system "make -j#{CREW_NPROC}"
  end
  def self.install
      system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
