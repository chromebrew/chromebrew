require 'package'

class Libpng < Package
  description 'libpng is the official PNG reference library.'
  homepage 'http://libpng.org/pub/png/libpng.html'
  version '1.6.36'
  source_url 'https://downloads.sourceforge.net/project/libpng/libpng16/1.6.36/libpng-1.6.36.tar.xz'
  source_sha256 'eceb924c1fa6b79172fdfd008d335f0e59172a86a66481e09d4089df872aa319'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libpng-1.6.36-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libpng-1.6.36-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libpng-1.6.36-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libpng-1.6.36-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '134223fd27b8f1fb39bd1f44c795d41b60b49070c9f5f8c7b582af53b090279e',
     armv7l: '134223fd27b8f1fb39bd1f44c795d41b60b49070c9f5f8c7b582af53b090279e',
       i686: 'd84e969b8f24fc998ed61bf4a669346216d6167ed9f9f5b026eac5acb47ea0a0',
     x86_64: 'fe2f3ba8855fbba9c0f81a1a5d377e78be56e8895e428e19c32b497417a8bf79',
  })

  depends_on 'zlibpkg'

  def self.patch
    # Fix /usr/bin/file: No such file or directory
    system 'filefix'
  end

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-dependency-tracking',
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
