require 'package'

class Harfbuzz < Package
  description 'HarfBuzz is an OpenType text shaping engine.'
  homepage 'https://www.freedesktop.org/wiki/Software/HarfBuzz/'
  version '1.7.6'
  source_url 'https://github.com/harfbuzz/harfbuzz/releases/download/1.7.6/harfbuzz-1.7.6.tar.bz2'
  source_sha256 'da7bed39134826cd51e57c29f1dfbe342ccedb4f4773b1c951ff05ff383e2e9b'


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
