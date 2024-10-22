require 'package'

class Libass < Package
  description 'A portable subtitle renderer for the ASS/SSA (Advanced Substation Alpha/Substation Alpha) subtitle format.'
  homepage 'https://github.com/libass/libass'
  version '0.14.0'
  license 'ISC'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/libass/libass/releases/download/0.14.0/libass-0.14.0.tar.xz'
  source_sha256 '881f2382af48aead75b7a0e02e65d88c5ebd369fe46bc77d9270a94aa8fd38a2'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '1749b98d9fcd1783cc6d04543ace006637732db0c0dab128597f86f122a1a28a',
     armv7l: '1749b98d9fcd1783cc6d04543ace006637732db0c0dab128597f86f122a1a28a',
     x86_64: '5d4f11533ac29592c4af827480bed3609ee8d4ee48e3b34bb3b68934da7e1248'
  })

  # depends_on 'automake' => :build
  # depends_on 'autoconf' => :build
  # depends_on 'libtool' => :build
  depends_on 'fribidi'
  depends_on 'fontconfig'

  def self.build
    system 'autoconf'
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
