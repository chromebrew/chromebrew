require 'package'

class Libfontenc < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '1.1.3'
  source_url 'https://www.x.org/archive/individual/lib/libfontenc-1.1.3.tar.gz'
  source_sha256 '6fba26760ca8d5045f2b52ddf641c12cedc19ee30939c6478162b7db8b6220fb'
  
  depends_on 'xorg_proto'
  depends_on 'zlibpkg'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
