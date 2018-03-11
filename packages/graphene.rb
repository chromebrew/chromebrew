require 'package'

class Graphene < Package
  description 'A thin layer of graphic data types'
  homepage 'https://github.com/ebassi/graphene'
  version '1.8.0'
  source_url 'https://github.com/ebassi/graphene/archive/1.8.0.tar.gz'
  source_sha256 '410f2e848952cc5830f39b6f6ea7f9b0a487cfe99dad86eec6f22ccbb3ec635b'

  binary_url ({

  })
  binary_sha256 ({

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
