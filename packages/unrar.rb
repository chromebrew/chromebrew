require 'package'

class Unrar < Package
  description 'UnRAR is a powerful archive extractor.'
  homepage 'http://www.rarlab.com/'
  version '5.6.3'
  compatibility 'all'
  source_url 'https://www.rarlab.com/rar/unrarsrc-5.6.3.tar.gz'
  source_sha256 'c590e70a745d840ae9b9f05ba6c449438838c8280d76ce796a26b3fcd0a1972e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/unrar-5.6.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/unrar-5.6.3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/unrar-5.6.3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/unrar-5.6.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ebf07529e4586d9494a41e0c0bc08d9c45b706a953ed9dc224b93e67f6b26cab',
     armv7l: 'ebf07529e4586d9494a41e0c0bc08d9c45b706a953ed9dc224b93e67f6b26cab',
       i686: '352da95a4126086f58fb69ae4aa4301f5464d52ac7c0d527e0434aaa6c846bee',
     x86_64: 'ff5bc1b1c1b2f04cfc69b42345df16cac2bfc4be64a15016825e7980b4f5683f',
  })

  def self.build
    # force to compile in sequential since unrar Makefile doesn't work in parallel
    system "make", "-j1", "all"
    system "make", "-j1", "lib"
  end

  def self.install
    system "make", "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_PREFIX}", "install"
  end
end
