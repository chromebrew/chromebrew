require 'package'

class Zsh < Package
  description 'Zsh is a shell designed for interactive use, although it is also a powerful scripting language.'
  homepage 'http://zsh.sourceforge.net/'
  version '5.0.7-1'
  source_url 'http://sourceforge.net/projects/zsh/files/zsh/5.0.7/zsh-5.0.7.tar.gz/download'
  source_sha256 '43f0a4c179ef79bb8c9153575685f7f45f28a3615c8cf96345f503d5b9e7b919'

  binary_url ({
  })
  binary_sha256 ({
    aarch64: '862a30e8e8098705e04b3691e97ede2e0c3b220bf1ea75d340beccfa1fda7d59',
     armv7l: '862a30e8e8098705e04b3691e97ede2e0c3b220bf1ea75d340beccfa1fda7d59',
       i686: 'ac3d4af763755593166c82ac88a0280fc9baa48896f7679f53c9bc77641adc56',
     x86_64: '0f6a804aeb501aefa86d4008972801a417789e0a7a7b025fea7f116b9bbe0dce',
  })

  depends_on 'ncurses'

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
