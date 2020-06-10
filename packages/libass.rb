require 'package'

class Libass < Package
  description 'A portable subtitle renderer for the ASS/SSA (Advanced Substation Alpha/Substation Alpha) subtitle format.'
  homepage 'https://github.com/libass/libass'
  version '0.14.0'
  compatibility 'all'
  source_url 'https://github.com/libass/libass/releases/download/0.14.0/libass-0.14.0.tar.xz'
  source_sha256 '881f2382af48aead75b7a0e02e65d88c5ebd369fe46bc77d9270a94aa8fd38a2'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libass-0.14.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libass-0.14.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libass-0.14.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libass-0.14.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1749b98d9fcd1783cc6d04543ace006637732db0c0dab128597f86f122a1a28a',
     armv7l: '1749b98d9fcd1783cc6d04543ace006637732db0c0dab128597f86f122a1a28a',
       i686: '6a3a7609356d407f7d2b6f4e0e9beedb89bf37bd5113a626ebe7e703d042caa1',
     x86_64: '5d4f11533ac29592c4af827480bed3609ee8d4ee48e3b34bb3b68934da7e1248',
  })

  #depends_on 'automake' => :build
  #depends_on 'autoconf' => :build
  #depends_on 'libtool' => :build
  depends_on 'fribidi'
  depends_on 'fontconfig'  
  
  def self.build
    system "autoconf"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
