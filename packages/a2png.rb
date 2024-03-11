require 'package'

class A2png < Package
  description 'Converts plain ASCII text into PNG bitmap images.'
  homepage 'https://sourceforge.net/projects/a2png/'
  version '0.1.5-1'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://sourceforge.net/projects/a2png/files/a2png/0.1.5/a2png-0.1.5.tar.bz2'
  source_sha256 'd3ae1c771f5180d93f35cded76d9bb4c4cc2023dbe65613e78add3eeb43f736b'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '72ebf874dee9871949df56eecd9b24e8586b84c1efed1bdf988f9ea9f28e012b',
     armv7l: '72ebf874dee9871949df56eecd9b24e8586b84c1efed1bdf988f9ea9f28e012b',
     x86_64: 'b468b226e28cf717c3f38435849bf737067a8b9ec3c1928c01fed5488bb31464'
  })

  depends_on 'cairo'

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --localstatedir=#{CREW_PREFIX}/tmp \
            --enable-cairo \
            --with-cairo-lib=#{CREW_LIB_PREFIX} \
            --with-cairo-include=#{CREW_PREFIX}/include/cairo"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
