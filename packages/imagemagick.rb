require 'package'

class Imagemagick < Package
  description 'Use ImageMagick to create, edit, compose, or convert bitmap images.'
  homepage 'http://www.imagemagick.org/script/index.php'
  version '7.0.6-10'
  source_url 'https://www.imagemagick.org/download/releases/ImageMagick-7.0.6-10.tar.xz'
  source_sha256 '5a9889c87dc351cf4b57ca3ae418c9cdcefc77aaa9a3b16044ae8a4eecf3aeed'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'buildessential' => :build

  def self.build
    system "./configure CFLAGS=\" -fPIC\" --without-python"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
