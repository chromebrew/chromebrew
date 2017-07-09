require 'package'

class Fribidi < Package
  description 'GNU FriBidi is an implementation of the Unicode Bidirectional Algorithm (bidi).'
  homepage 'https://www.fribidi.org/'
  version '0.19.7'
  source_url 'https://www.fribidi.org/download/fribidi-0.19.7.tar.bz2'
  source_sha256 '08222a6212bbc2276a2d55c3bf370109ae4a35b689acbc66571ad2a670595a8e'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/fribidi-0.19.7-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/fribidi-0.19.7-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/fribidi-0.19.7-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/fribidi-0.19.7-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '66631c0d358d9e548e46b676221e8495592a14e986850141771c8115fb8c33d3',
     armv7l: '66631c0d358d9e548e46b676221e8495592a14e986850141771c8115fb8c33d3',
       i686: 'a2898c1b77f70adc5ce26feae9a66cd3ecde3244636d42b12bac22b2d32e99d6',
     x86_64: '8e384469c614322d456406fa7c938f3781910e684d9aa0ef588e3355f8a0af75',
  })

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
