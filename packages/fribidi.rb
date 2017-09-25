require 'package'

class Fribidi < Package
  description 'GNU FriBidi is an implementation of the Unicode Bidirectional Algorithm (bidi).'
  homepage 'https://www.fribidi.org/'
  version '0.19.7-1'
  source_url 'https://www.fribidi.org/download/fribidi-0.19.7.tar.bz2'
  source_sha256 '08222a6212bbc2276a2d55c3bf370109ae4a35b689acbc66571ad2a670595a8e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fribidi-0.19.7-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fribidi-0.19.7-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fribidi-0.19.7-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fribidi-0.19.7-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3eeff0ca03e6e8c353550e30bbfb8885362bdd9d1365a9445801ef10a12b0b0e',
     armv7l: '3eeff0ca03e6e8c353550e30bbfb8885362bdd9d1365a9445801ef10a12b0b0e',
       i686: '3d6d97d77fd173dfcec01519a2c063bce04deb3f12e4f6c99f9a69e5791eafd5',
     x86_64: '724861889162ef2cc4c38fe419730c508652936a95390270a74783205fb82fce',
  })

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
