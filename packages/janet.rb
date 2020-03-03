require 'package'

class Janet < Package
  description 'Janet is a functional and imperative programming language and bytecode interpreter.'
  homepage 'https://janet-lang.org'
  version '1.7.0'
  source_url 'https://github.com/janet-lang/janet/archive/v1.7.0.tar.gz'
  source_sha256 '2a119f3a79b209a858864e73ca3efda57ac044df3c89762a31480bbea386d2a3'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'meson'  => :build
  
  def self.build
    system "meson --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} builddir"
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
  
end
