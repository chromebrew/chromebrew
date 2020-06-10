require 'package'

class Libcerf < Package
  description 'a self-contained numeric library that provides an efficient and accurate implementation of complex error functions, along with Dawson, Faddeeva, and Voigt functions.'
  homepage 'http://apps.jcns.fz-juelich.de/doku/sc/libcerf'
  version '1.5'
  compatibility 'all'
  source_url 'http://apps.jcns.fz-juelich.de/src/libcerf/libcerf-1.5.tgz'
  source_sha256 'e36dc147e7fff81143074a21550c259b5aac1b99fc314fc0ae33294231ca5c86'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libcerf-1.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libcerf-1.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libcerf-1.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libcerf-1.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '94fc2717e970fb97ce0c508a191c5249b99af6b5f29f0855c7494593b827c063',
     armv7l: '94fc2717e970fb97ce0c508a191c5249b99af6b5f29f0855c7494593b827c063',
       i686: 'e5e03923be7e965ee27e56b38a1d6dc147dcab47bf01837f8db44fbdde76cc99',
     x86_64: '0ab2007863a453cd498c9a2be2ffd42ea37e3c469cb1874547916a0375482a0c',
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
