require 'package'

class Texinfo < Package
  description 'Texinfo is the official documentation format of the GNU project.'
  homepage 'https://www.gnu.org/software/texinfo/'
  version '6.3'
  source_url 'http://ftp.gnu.org/gnu/texinfo/texinfo-6.3.tar.gz'
  source_sha1 '29b16c646c7bc9cd351b2f1d8dafdce70e5377f6'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
