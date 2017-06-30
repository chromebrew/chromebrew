require 'package'

class Fribidi < Package
  description 'GNU FriBidi is an implementation of the Unicode Bidirectional Algorithm (bidi).'
  homepage 'https://www.fribidi.org/'
  version '0.19.7'
  source_url 'https://www.fribidi.org/download/fribidi-0.19.7.tar.bz2'
  source_sha256 '08222a6212bbc2276a2d55c3bf370109ae4a35b689acbc66571ad2a670595a8e'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
