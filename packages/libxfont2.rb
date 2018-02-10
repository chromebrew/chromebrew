require 'package'

class Libxfont2 < Package
  description 'X.org X font library'
  homepage 'http://www.x.org'
  version '2.0.3'
  source_url 'https://www.x.org/archive/individual/lib/libXfont2-2.0.3.tar.gz'
  source_sha256 'a4b761a37528353a2b83dba364d7c1fd6aef2d554a1a019815f24f7f8866890e'

  depends_on 'libxtrans'
  depends_on 'libfontenc'
  depends_on 'libx11'
  depends_on 'freetype'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end