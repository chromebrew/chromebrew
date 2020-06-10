require 'package'

class Mtdev < Package
  description 'The mtdev is a stand-alone library which transforms all variants of kernel MT events to the slotted type B protocol.'
  homepage 'http://bitmath.org/code/mtdev'
  version '1.1.5-0'
  compatibility 'all'
  source_url 'http://bitmath.org/code/mtdev/mtdev-1.1.5.tar.bz2'
  source_sha256 '6677d5708a7948840de734d8b4675d5980d4561171c5a8e89e54adf7a13eba7f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mtdev-1.1.5-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mtdev-1.1.5-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mtdev-1.1.5-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mtdev-1.1.5-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '6c0bbb0650a3777648f106279d11e702c75c01c2b036f113bd8cf0cab6bf463a',
     armv7l: '6c0bbb0650a3777648f106279d11e702c75c01c2b036f113bd8cf0cab6bf463a',
       i686: '0a18d63b9ecbd32dabc98e0b63f8514696ffd133227a42173193e828e1e7752f',
     x86_64: 'ef6142c6cbaa71698acbb2cfcc3c40d5e9674931adfbb7352ce71b9b45c1027f',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-shared',
           '--disable-static'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
