require 'package'

class Tig < Package
  description 'Tig is an ncurses-based text-mode interface for git.'
  homepage 'http://jonas.nitro.dk/tig/'
  version '2.2.1'
  source_url 'https://github.com/jonas/tig/archive/tig-2.2.1.tar.gz'
  source_sha256 '92d96635068d779df58aea3fbfa86c5869e39c11c7868d5b3d62229360b5336f'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/tig-2.2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/tig-2.2.1-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/tig-2.2.1-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/tig-2.2.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '97f4ba9efd176c65a6ae786f004063c49109b5016e7e9966f6b2ac3c4ea6bbda',
     armv7l: '97f4ba9efd176c65a6ae786f004063c49109b5016e7e9966f6b2ac3c4ea6bbda',
       i686: 'a2779eedcdb478c9d0a98260ca33c0b1c57c8eebd5422f1a2cb75cbaca7eaad1',
     x86_64: '891f7b0eb38ca801bcac16e7592652609677d64fc66dcf9e85a9abe5ad6a4457',
  })

  depends_on 'readline'
  depends_on 'ncurses'

  def self.build
    system "./autogen.sh"
    system "./configure", "--prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
