require 'package'

class Neovim < Package
  description 'Neovim is a refactor, and sometimes redactor, in the tradition of Vim (which itself derives from Stevie).'
  homepage 'https://neovim.io/'
  version '0.1.7'
  source_url 'https://github.com/neovim/neovim/archive/v0.1.7.tar.gz'
  source_sha256 'd8f885d019b1ad608f36ae23b8f1b15b7e33585e16f7514666ab6c9809bb4b7e'

  depends_on 'libtool'
  depends_on 'autoconf'
  depends_on 'automake'
  depends_on 'cmake'
  depends_on 'gcc'
  depends_on 'pkgconfig'
  depends_on 'unzip'

  def self.build
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
