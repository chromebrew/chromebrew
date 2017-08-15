require 'package'

class Unrar < Package
  description 'UnRAR is a powerful archive extractor.'
  homepage 'http://www.rarlab.com/'
  version '5.4.5'
  source_url 'http://www.rarlab.com/rar/unrarsrc-5.4.5.tar.gz'
  source_sha256 'e470c584332422893fb52e049f2cbd99e24dc6c6da971008b4e2ae4284f8796c'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/unrar-5.4.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/unrar-5.4.5-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/unrar-5.4.5-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/unrar-5.4.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'af75463a906436baf4718febdc9e2a2d61150cf5df30fd244b2b808cf4f16929',
     armv7l: 'af75463a906436baf4718febdc9e2a2d61150cf5df30fd244b2b808cf4f16929',
       i686: '7e5c893ed0e8d5ba41c59a1dbda6b47a062e121b85e2e1c14ad72a393a0d6540',
     x86_64: 'a4d98de19dcede1e90c31f575b68534c6a55e93a248df109a9c087f0c21f53e4',
  })

  def self.build
    system "sed -i '145s,$,/libunrar.so,' makefile" # fix naming mistake
    system "sed -i '145s,install,install -D,' makefile" # create directory

    # force to compile in sequential since unrar Makefile doesn't work in parallel
    system "make", "-j1", "all"
    system "make", "-j1", "lib"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}/usr/local", "install"
    system "make", "DESTDIR=#{CREW_DEST_DIR}/usr/local", "install-lib"
  end
end
