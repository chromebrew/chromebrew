require 'package'

class Aspell_en < Package
  description 'English Aspell Dictionary'
  homepage 'ftp://ftp.gnu.org/gnu/aspell/dict/0index.html'
  version '2017.01.22-0'
  source_url 'ftp://ftp.gnu.org/gnu/aspell/dict/en/aspell6-en-2017.01.22-0.tar.bz2'
  source_sha256 '93c73fae3eab5ea3ca6db3cea8770715a820f1b7d6ea2b932dd66a17f8fd55e1'

  depends_on 'aspell'

  def self.build
    system './configure'
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
