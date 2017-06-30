require 'package'

class Fontconfig < Package
  description 'Fontconfig is a library for configuring and customizing font access.'
  homepage 'https://www.freedesktop.org/software/fontconfig/front.html'
  version '2.11.94-1'
  source_url 'http://www.freedesktop.org/software/fontconfig/release/fontconfig-2.11.94.tar.gz'
  source_sha256 '73f6d323c7bcfbde25d78397675191d55b8f4139132c6a9444410f3a2d8a9a95'

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
