require 'package'

class Tinycc < Package
  description 'TinyCC (aka TCC) is a small but hyper fast C compiler.'
  homepage 'http://bellard.org/tcc/'
  version '0.9.27'
  source_url 'http://download.savannah.gnu.org/releases/tinycc/tcc-0.9.27.tar.bz2'
  source_sha256 'de23af78fca90ce32dff2dd45b3432b2334740bb9bb7b05bf60fdbfc396ceb9c'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "./configure --prefix=/usr/local"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
