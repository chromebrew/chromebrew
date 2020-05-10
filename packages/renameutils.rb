require 'package'

class Renameutils < Package
  description 'The file renaming utilities (renameutils for short) are a set of programs designed to make renaming of files faster and less cumbersome.'
  homepage 'http://www.nongnu.org/renameutils/'
  version '0.12.0'
  compatibility 'all'
  source_url 'http://download.savannah.gnu.org/releases/renameutils/renameutils-0.12.0.tar.gz'
  source_sha256 'cbd2f002027ccf5a923135c3f529c6d17fabbca7d85506a394ca37694a9eb4a3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/renameutils-0.12.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/renameutils-0.12.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/renameutils-0.12.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/renameutils-0.12.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2e497d4cb92fcea0d44dcc4096031bbc37a54d7825ac956179190cca410f7312',
     armv7l: '2e497d4cb92fcea0d44dcc4096031bbc37a54d7825ac956179190cca410f7312',
       i686: '3020f072735772221722b17b7876320176bc0193e7207495c0ece96e7b44c71d',
     x86_64: '5e640502df11cb89c18744823782b491dab5c3a79ec52b89b9381373339d3517',
  })

  def self.build
    system "sed -i 's,($bindir),$(bindir),g' src/Makefile.am"
    system "sed -i 's,($bindir),$(bindir),g' src/Makefile.in"
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
