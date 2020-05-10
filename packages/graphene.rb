require 'package'

class Graphene < Package
  description 'A thin layer of graphic data types'
  homepage 'https://github.com/ebassi/graphene'
  version '1.8.0'
  compatibility 'all'
  source_url 'https://github.com/ebassi/graphene/archive/1.8.0.tar.gz'
  source_sha256 '410f2e848952cc5830f39b6f6ea7f9b0a487cfe99dad86eec6f22ccbb3ec635b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/graphene-1.8.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/graphene-1.8.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/graphene-1.8.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/graphene-1.8.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2a7f9e8dd9a28ef882bedbdd177824c4e51add7e7457f3908369277e7825890f',
     armv7l: '2a7f9e8dd9a28ef882bedbdd177824c4e51add7e7457f3908369277e7825890f',
       i686: 'dc070efb57d7b780e7d53993c9d531cca24a9b5cf96831b4904ffd5bc140a51a',
     x86_64: '851d4dee78563bee5938d43bd263781ac3851fc43db93d9d946055ea44831b7b',
  })

  depends_on 'meson'
  depends_on 'gobject_introspection' => :build

  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} -Darm_neon=false _build"           
    system "ninja -v -C _build"
    system "ninja -C _build test"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C _build install"
  end 
end
