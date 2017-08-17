require 'package'

class Imagemagick < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '7.0.6-7'
  source_url 'https://www.imagemagick.org/download/releases/ImageMagick-7.0.6-7.tar.xz'
  source_sha256 '732332a76cb62f067d680a90d85dd05a2f2592e0017af83becb639d05681106d'

  depends_on 'buildessential' => :build

  def self.build
    system "./configure CFLAGS=\" -fPIC\" --without-python"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
