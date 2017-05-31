require 'package'

class Fontconfig < Package
  description 'Fontconfig is a library for configuring and customizing font access.'
  homepage 'https://www.freedesktop.org/software/fontconfig/front.html'
  version '2.11.94-1'
  source_url 'http://www.freedesktop.org/software/fontconfig/release/fontconfig-2.11.94.tar.gz'
  source_sha1 '3748d8a2b9cf8052dbd003f524d829157f1ead83'

  depends_on 'pkgconfig'
  depends_on 'freetype'

  def self.build
      system "./configure CFLAGS=\" -fPIC\""
      system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
