require 'package'

class Stow < Package
  description 'Manage installation of multiple softwares in the same directory tree'
  homepage 'https://www.gnu.org/software/stow/'
  version '2.2.2'
  source_url 'https://ftp.gnu.org/gnu/stow/stow-2.2.2.tar.gz'
  source_sha256 'e2f77649301b215b9adbc2f074523bedebad366812690b9dc94457af5cf273df'

  depends_on 'buildessential' => :build
  depends_on 'perl'

  def self.build
    system "./configure", "--prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
