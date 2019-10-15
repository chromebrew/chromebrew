require 'package'

class Neovim < Package
  description 'Neovim is a refactor, and sometimes redactor, in the tradition of Vim (which itself derives from Stevie).'
  homepage 'https://neovim.io/'
  version '0.4.2'
  source_url 'https://github.com/neovim/neovim/archive/v0.4.2.tar.gz'
  source_sha256 '9f874d3d2a74f33b931db62adebe28f8d2ec116270d1e13998b58a73348b6e56'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system "make", "CMAKE_BUILD_TYPE=RelWithDebInfo", "CFLAGS=-fstack-protector-all"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
