require 'package'

class Ed < Package
  description 'GNU ed is a line-oriented text editor.'
  homepage 'http://www.gnu.org/software/ed/ed.html'
  version '1.14.2-1'
  source_url 'http://ftpmirror.gnu.org/ed/ed-1.14.2.tar.lz'
  source_sha1 '3e8aa331ffbc929884107ff3f8fbd76d01252277'

  # only lz archive is available for ed and it requires lzip.
  depends_on 'lzip' => :build

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"
  end

  def self.check
    system "make", "check"
  end
end
