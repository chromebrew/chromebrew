require 'package'

class Nano < Package
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  version '2.9.1'
  source_url 'https://www.nano-editor.org/dist/v2.9/nano-2.9.1.tar.xz'
  source_sha256 '6316d52d0d26af3e79a13dcb4db1c7a4aeac61b37fd9381e801a4189a2ecba7c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/nano-2.9.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/nano-2.9.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/nano-2.9.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/nano-2.9.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'c2c3367cab170f5561bda70d0a50b6a214f552133dc9b3f927484167b761b5ae',
     armv7l: 'c2c3367cab170f5561bda70d0a50b6a214f552133dc9b3f927484167b761b5ae',
       i686: '63c0d80e9d45e0ce5985d8d15d10a2bc5945d6ac86cbb91d545f5516a1c36539',
     x86_64: '680533f195e883574b6591bcdba703e1ae36d01066e93f5f3eaacb104ef26702',
  })

  depends_on 'ncurses'
  depends_on 'filecmd'

  def self.build
    system "./configure \
              --prefix=#{CREW_PREFIX} \
              CPPFLAGS=\"-I#{CREW_PREFIX}/include/ncurses\""
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
