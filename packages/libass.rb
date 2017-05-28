require 'package'

class Libass < Package
  version '0.13.6'
  source_url 'https://github.com/libass/libass/archive/0.13.6.tar.gz'
  source_sha1 '10fc35f8aba2a4a37aaed482a4184d144defb3d8'

  depends_on 'freetype'
  depends_on 'fribidi'
  depends_on 'fontconfig'

  def self.build
    system "./autogen.sh"
    system "autoconf"
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
