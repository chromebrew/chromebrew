require 'package'

class Atk < Package
  description 'ATK provides the set of accessibility interfaces that are implemented by other tookits and applications'
  homepage 'https://developer.gnome.org/atk'
  version '2.26.1'
  compatibility 'all'
  source_url 'https://download.gnome.org/sources/atk/2.26/atk-2.26.1.tar.xz'
  source_sha256 'ef00ff6b83851dddc8db38b4d9faeffb99572ba150b0664ee02e46f015ea97cb'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/atk-2.26.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/atk-2.26.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/atk-2.26.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/atk-2.26.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '70c1f880c008c5f4282881ec3874db7b10967d2b5cdb6e6ad6ccdcad3ce474b7',
     armv7l: '70c1f880c008c5f4282881ec3874db7b10967d2b5cdb6e6ad6ccdcad3ce474b7',
       i686: 'f23be7cebc618b3c77e0a2f600cca826c76e31fba9ecf4161acfd464a7ee67a4',
     x86_64: '9207587db8548706d1fd592aee5f2e501218d9c44367b0f9826869a44215989b',
  })

  depends_on 'gobject_introspection'
  depends_on 'six' => :build

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
