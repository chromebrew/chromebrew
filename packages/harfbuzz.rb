require 'package'

class Harfbuzz < Package
  description 'HarfBuzz is an OpenType text shaping engine.'
  homepage 'https://www.freedesktop.org/wiki/Software/HarfBuzz/'
  version '1.7.6-0'
  source_url 'https://github.com/harfbuzz/harfbuzz/releases/download/1.7.6/harfbuzz-1.7.6.tar.bz2'
  source_sha256 'da7bed39134826cd51e57c29f1dfbe342ccedb4f4773b1c951ff05ff383e2e9b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/harfbuzz-1.7.6-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/harfbuzz-1.7.6-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/harfbuzz-1.7.6-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/harfbuzz-1.7.6-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd92567e640f2b847ff35d1dcb5e0fcabaa640cea8c709755a3fed8b1ed59a598',
     armv7l: 'd92567e640f2b847ff35d1dcb5e0fcabaa640cea8c709755a3fed8b1ed59a598',
       i686: '220ae1416d6fb21e9d5621d97c66e65dddd15eb63108fb4c5e3d5fe6c75e662a',
     x86_64: '3dd360778d0ffbd12b23a9d1e2fe5d3031f8a93eb9f9618cd430dc91349bee7d',
  })

  depends_on 'glib'
  depends_on 'icu4c'
  depends_on 'freetype_sub'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "pip install six"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "pip uninstall --yes six"
  end
end
