require 'package'

class Patchelf < Package
  version '0.8'
  source_url 'http://download.mono-project.com/sources/mono/mono-4.2.2.30.tar.bz2'
  source_sha1 '84aa9712dff9f61a45a6bf76d6c3bf81bebddca8'

  def self.build
    system "./configure --disable-dependency-tracking --disable-silent-rules --enable-nls=no", "prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "PREFIX=#{CREW_DEST_DIR}/usr/local", "install"
  end
end
