require 'package'

class Neovim < Package
  description 'Neovim is a refactor, and sometimes redactor, in the tradition of Vim (which itself derives from Stevie).'
  homepage 'https://neovim.io/'
  version '0.2.0'
  source_url 'https://github.com/neovim/neovim/archive/v0.2.0.tar.gz'
  source_sha256 '72e263f9d23fe60403d53a52d4c95026b0be428c1b9c02b80ab55166ea3f62b5'

  depends_on 'libtool'
  depends_on 'autoconf'
  depends_on 'automake'
  depends_on 'cmake'
  depends_on 'gcc'
  depends_on 'pkgconfig'
  depends_on 'unzip'

  def self.build
    system "make", "CMAKE_BUILD_TYPE=RelWithDebInfo"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
