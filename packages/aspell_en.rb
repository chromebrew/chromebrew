require 'package'

class Aspell_en < Package
  description 'English Aspell Dictionary'
  homepage 'https://ftpmirror.gnu.org/aspell/dict/0index.html'
  version '2020.12.07-0'
  compatibility 'all'
  source_url 'https://gnu.askapache.com/aspell/dict/en/aspell6-en-2020.12.07-0.tar.bz2'
  source_sha256 '4c8f734a28a088b88bb6481fcf972d0b2c3dc8da944f7673283ce487eac49fb3'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/aspell_en-2020.12.07-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/aspell_en-2020.12.07-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/aspell_en-2020.12.07-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/aspell_en-2020.12.07-0-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'a3f897c049eb4c7b6caf9c1d08c894b6f9541681a0ce9cd2b664226a1574d69d',
     armv7l: 'a3f897c049eb4c7b6caf9c1d08c894b6f9541681a0ce9cd2b664226a1574d69d',
       i686: 'ec4684e5665cf4ef98c90ac28567e2d5a6833c9468263486eb81e3fd2d1e27ca',
     x86_64: '2b39dd619b454a9fcf4bad9b09b4a60163744209dc9dbad4c87c0971bca363f1'
  })

  depends_on 'aspell'

  def self.build
    system "env CFLAGS='-flto=auto -ltinfo' CXXFLAGS='-flto=auto' \
        LDFLAGS='-flto=auto' ./configure"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
