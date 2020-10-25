require 'package'

class Freetype_sub < Package
  description 'Freetype_sub is a version without harfbuzz. It is intended to handle circular dependency betwwen freetype and harfbuzz.'
  homepage 'https://www.freetype.org/'
  version '2.10.4'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/freetype/freetype-2.10.4.tar.xz'
  source_sha256 '86a854d8905b19698bbc8f23b860bc104246ce4854dcea8e3b0fb21284f75784'

  depends_on 'expat'
  depends_on 'libpng'   # freetype needs zlib optionally. zlib is also the dependency of libpng
  depends_on 'bz2'
  
  def self.build
    system 'pip3 install docwriter'
    system "./configure CFLAGS=' -fPIC' #{CREW_OPTIONS} --enable-freetype-config --without-harfbuzz"
    system 'make'
    system 'pip3 uninstall docwriter -y'
    system "pip3 install docwriter --root #{CREW_DEST_DIR} --prefix #{CREW_PREFIX}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
  
  def self.postinstall
    system "find #{CREW_BREW_DIR}/* -name freetype*.tar | xargs rm -rf"  # make sure to delete downloaded files
  end
end
