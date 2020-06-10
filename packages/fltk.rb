require 'package'

class Fltk < Package
  description 'Fast Light Toolkit or FLTK (pronounced "fulltick") is a cross-platform C++ GUI toolkit'
  homepage 'https://www.fltk.org/'
  version '1.3.5'
  compatibility 'all'
  source_url 'https://www.fltk.org/pub/fltk/1.3.5/fltk-1.3.5-source.tar.bz2'
  source_sha256 '2933c72400f9e7c0f4c3a81a1ce98bc9582b2a3edc44b8597ccd26e240e32c3c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fltk-1.3.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fltk-1.3.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/fltk-1.3.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fltk-1.3.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '98d7e8f6846f357be4b7600b016fe4f1800c8e7e08d1846227c674fa7e0a7a89',
     armv7l: '98d7e8f6846f357be4b7600b016fe4f1800c8e7e08d1846227c674fa7e0a7a89',
       i686: 'ee29eb618e5f09f1486e56061c5b82d1a331dba26eb0e0329020641261d6ac92',
     x86_64: '95fabef98ee5b2fc9c7ba32ea8f62bf0193322b791f8048d4ee003d76b7c8e83',
  })

  depends_on 'sommelier'

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
      system 'cmake',
             '-DCMAKE_BUILD_TYPE=Release',
             "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX}",
             '-DOPTION_BUILD_EXAMPLES=OFF',
             '..'
      system 'make'
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    end
  end
end
