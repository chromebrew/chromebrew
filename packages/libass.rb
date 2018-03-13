require 'package'

class Libass < Package
  description 'A portable subtitle renderer for the ASS/SSA (Advanced Substation Alpha/Substation Alpha) subtitle format.'
  homepage 'https://github.com/libass/libass'
  version '0.13.6-2'
  source_url 'https://github.com/libass/libass/archive/0.13.6.tar.gz'
  source_sha256 'de68288397d284a955061b3ecba67152cea74d8ace6222d987dd30091b1534b7'



  depends_on 'automake' => :build
  depends_on 'autoconf' => :build
  depends_on 'freetype'
  depends_on 'fribidi'
  depends_on 'fontconfig'
  depends_on 'libtool' => :build

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
