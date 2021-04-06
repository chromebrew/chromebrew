require 'package'

class Freetype < Package
  description 'FreeType is a freely available software library to render fonts.'
  homepage 'https://www.freetype.org/'
  version '2.10.4-1'
  license 'FTL or GPL-2+'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/freetype/freetype-2.10.4.tar.xz'
  source_sha256 '86a854d8905b19698bbc8f23b860bc104246ce4854dcea8e3b0fb21284f75784'

  depends_on 'expat'
  depends_on 'libpng'   # freetype needs zlib optionally. zlib is also the dependency of libpng
  depends_on 'bz2'
  depends_on 'harfbuzz'
  depends_on 'py3_docwriter'

  def self.build
    system "sed -i 's,/usr/include/freetype2,#{CREW_PREFIX}/include/freetype2,g' configure"
    system "./configure CFLAGS=' -fPIC' #{CREW_OPTIONS} --enable-freetype-config --with-harfbuzz"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
