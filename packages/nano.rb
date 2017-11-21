require 'package'

class Nano < Package
  description 'Nano\'s ANOther editor, an enhanced free Pico clone.'
  homepage 'https://www.nano-editor.org/'
  version '2.9.0'
  source_url 'https://www.nano-editor.org/dist/v2.9/nano-2.9.0.tar.xz'
  source_sha256 'd2d30c39caef53aba1ec1b4baff4186d4496f35d2411b0848242a5f2e27e129e'

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
