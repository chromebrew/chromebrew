require 'package'

class Libxres < Package
  description 'X.org X-Resource extension client library'
  homepage 'http://www.x.org'
  version '1.2.0'
  source_url 'https://www.x.org/archive/individual/lib/libXres-1.2.0.tar.gz'
  source_sha256 '5b62feee09f276d74054787df030fceb41034de84174abec6d81c591145e043a'

  depends_on 'libxext'
  depends_on 'resourceproto'
  depends_on 'libx11'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end