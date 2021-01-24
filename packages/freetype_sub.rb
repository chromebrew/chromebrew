require 'package'

class Freetype_sub < Package
  description 'Freetype_sub is a version without harfbuzz. It is intended to handle circular dependency betwwen freetype and harfbuzz.'
  homepage 'https://www.freetype.org/'
  version '2.10.4'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/freetype/freetype-2.10.4.tar.xz'
  source_sha256 '86a854d8905b19698bbc8f23b860bc104246ce4854dcea8e3b0fb21284f75784'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/freetype_sub-2.10.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/freetype_sub-2.10.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/freetype_sub-2.10.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/freetype_sub-2.10.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7c8620a0cad19fbcd7ff0d96a7304323648b97c93d86352cfbb8216c768aeb1b',
     armv7l: '7c8620a0cad19fbcd7ff0d96a7304323648b97c93d86352cfbb8216c768aeb1b',
       i686: '4e6ab3e8a7dacab4380099315c2d547b89ce490f33d7e677744034d4e44ccabe',
     x86_64: 'a5c364bdee4a22ca72bbaba4162dc2d75730f15b4340bddf038ee3698751c116',
  })

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
