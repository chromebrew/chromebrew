require 'package'

class Ed < Package
  description 'GNU ed is a line-oriented text editor.'
  homepage 'http://www.gnu.org/software/ed/ed.html'
  version '1.14.2-1'
  source_url 'http://ftpmirror.gnu.org/ed/ed-1.14.2.tar.lz'
  source_sha256 'f57962ba930d70d02fc71d6be5c5f2346b16992a455ab9c43be7061dec9810db'

  # only lz archive is available for ed and it requires lzip.
  depends_on 'lzip' => :build

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
