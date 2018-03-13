require 'package'

class Libass < Package
  description 'A portable subtitle renderer for the ASS/SSA (Advanced Substation Alpha/Substation Alpha) subtitle format.'
  homepage 'https://github.com/libass/libass'
  version '0.14.0'
  source_url 'https://github.com/libass/libass/releases/download/0.14.0/libass-0.14.0.tar.xz'
  source_sha256 '881f2382af48aead75b7a0e02e65d88c5ebd369fe46bc77d9270a94aa8fd38a2'


  def self.build
    system "./autogen.sh"
    system "autoconf"
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
