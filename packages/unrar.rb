require 'package'

class Unrar < Package
  description 'UnRAR is a powerful archive extractor.'
  homepage 'http://www.rarlab.com/'
  version '5.5.8'
  source_url 'http://www.rarlab.com/rar/unrarsrc-5.5.8.tar.gz'
  source_sha256 '9b66e4353a9944bc140eb2a919ff99482dd548f858f5e296d809e8f7cdb2fcf4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/unrar-5.4.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/unrar-5.4.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/unrar-5.4.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/unrar-5.4.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'af75463a906436baf4718febdc9e2a2d61150cf5df30fd244b2b808cf4f16929',
     armv7l: 'af75463a906436baf4718febdc9e2a2d61150cf5df30fd244b2b808cf4f16929',
       i686: '7e5c893ed0e8d5ba41c59a1dbda6b47a062e121b85e2e1c14ad72a393a0d6540',
     x86_64: 'a4d98de19dcede1e90c31f575b68534c6a55e93a248df109a9c087f0c21f53e4',
  })

  def self.build
    # force to compile in sequential since unrar Makefile doesn't work in parallel
    system "make", "-j1", "all"
    system "make", "-j1", "lib"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_PREFIX}", "install"
    system "mkdir -p #{CREW_DEST_LIB_PREFIX}"
    system "cp libunrar.so #{CREW_DEST_LIB_PREFIX}/libunrar.so"
  end
end
