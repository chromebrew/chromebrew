require 'package'

class Nano < Package
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  version '2.9.1'
  source_url 'https://www.nano-editor.org/dist/v2.9/nano-2.9.1.tar.xz'
  source_sha256 '6316d52d0d26af3e79a13dcb4db1c7a4aeac61b37fd9381e801a4189a2ecba7c'

  binary_url ({
  })
  binary_sha256 ({
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
