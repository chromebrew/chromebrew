require 'package'

class Libxaw < Package
  description 'X.org X Athena Widgets Library'
  homepage 'http://www.x.org'
  version '1.0.13'
  source_url 'https://www.x.org/archive/individual/lib/libXaw-1.0.13.tar.gz'
  source_sha256 '7e74ac3e5f67def549722ff0333d6e6276b8becd9d89615cda011e71238ab694'

  depends_on 'libxmu'
  depends_on 'libxpm'
  depends_on 'libx11'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end