require 'package'

class Harfbuzz < Package
  description 'HarfBuzz is an OpenType text shaping engine.'
  homepage 'https://www.freedesktop.org/wiki/Software/HarfBuzz/'
  version '1.7.4'
  source_url 'https://github.com/harfbuzz/harfbuzz/releases/download/1.7.4/harfbuzz-1.7.4.tar.bz2'
  source_sha256 'b5d6ac8415f97f3540d73f3f91c41c5c10f8a4d76350f11a7184062aae88ac0b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/harfbuzz-1.7.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/harfbuzz-1.7.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/harfbuzz-1.7.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/harfbuzz-1.7.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd8ff274794aedf077221774d6981cbdb43fe2ad1e43d839772c593b0c85c36c6',
     armv7l: 'd8ff274794aedf077221774d6981cbdb43fe2ad1e43d839772c593b0c85c36c6',
       i686: '7d1dac76e4cf30334c072a802cac99d33e12ed9f229753e9b1faa4ae0e3eafa8',
     x86_64: 'a14c9919355fbadd0bbc8eac493029a92801741f6106050e76abc335582f3e78',
  })

  depends_on 'glib'
  depends_on 'icu4c'
  depends_on 'freetype'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
