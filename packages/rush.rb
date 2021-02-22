require 'package'

class Rush < Package
  description 'GNU Rush is a Restricted User Shell.'
  homepage 'https://www.gnu.org/software/rush/'
  version '2.1'
  compatibility 'all'
  source_url 'https://ftpmirror.gnu.org/rush/rush-2.1.tar.xz'
  source_sha256 'c2ff487d44ce3d14854d0269eb0aa4c0f98bcca35390fad5ea52da75d9e4abdf'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/rush-2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/rush-2.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/rush-2.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/rush-2.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3b5629f53b3efc539ba397302fddd223fce1cbe5e5dee50be3e3d36868424984',
     armv7l: '3b5629f53b3efc539ba397302fddd223fce1cbe5e5dee50be3e3d36868424984',
       i686: '005bf529cd4383852c40f426e8c3f2cb44107888a14590bbb570ef90266bf18c',
     x86_64: '69e660ca63ddfa08b4d4da0884ede5826715aaec6c189e79214ac4c8b30f3cd5',
  })

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
  
  def self.check
    system "make", "check"
  end
end
