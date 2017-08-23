require 'package'

class Renameutils < Package
  description 'The file renaming utilities (renameutils for short) are a set of programs designed to make renaming of files faster and less cumbersome.'
  homepage 'http://www.nongnu.org/renameutils/'
  version '0.12.0'
  source_url 'http://download.savannah.gnu.org/releases/renameutils/renameutils-0.12.0.tar.gz'
  source_sha256 'cbd2f002027ccf5a923135c3f529c6d17fabbca7d85506a394ca37694a9eb4a3'

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
