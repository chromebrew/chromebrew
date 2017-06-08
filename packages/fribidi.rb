require 'package'

class Fribidi < Package
  description 'GNU FriBidi is an implementation of the Unicode Bidirectional Algorithm (bidi).'
  homepage 'https://www.fribidi.org/'
  version '0.19.7'
  source_url 'https://www.fribidi.org/download/fribidi-0.19.7.tar.bz2'
  source_sha1 'e470e078eafe6c065708def3e037c129c0d7367d'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
