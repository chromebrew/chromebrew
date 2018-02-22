require 'package'

class Clean < Package
  description 'Clean is a program that searches for files identified by regular expressions and deletes them'
  homepage 'https://sourceforge.net/projects/clean/'
  version '3.4'
  source_url 'http://downloads.sourceforge.net/project/clean/clean/3.4/clean-3.4.tar.bz2'
  source_sha256 '761f3a9e1ed50747b6a62a8113fa362a7cc74d359ac6e8e30ba6b30d59115320'

  def self.build
    system "make"
  end

  def self.install
    system "install -Dm755 -s clean #{CREW_DEST_PREFIX}/bin/clean"
    system "install -Dm644 clean.1 #{CREW_DEST_PREFIX}/share/man/man1/clean.1"
  end
end
