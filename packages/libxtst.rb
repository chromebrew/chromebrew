require 'package'

class Libxtst < Package
  description 'X.org Xtst Library'
  homepage 'http://t2sde.org/packages/libxtst.html'
  version '1.2.3'
  source_url 'https://xorg.freedesktop.org/releases/individual/lib/libXtst-1.2.3.tar.bz2'
  source_sha256 '4655498a1b8e844e3d6f21f3b2c4e2b571effb5fd83199d428a6ba7ea4bf5204'


  depends_on 'libxi'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
