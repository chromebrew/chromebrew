require 'package'

class Libuninum < Package
  description 'This is a library for converting Unicode strings to numbers and numbers to Unicode strings.'
  homepage 'http://billposer.org/Software/libuninum.html'
  version '2.7-0'
  source_url 'https://billposer.org/Software/Downloads/libuninum-2.7.tar.bz2'
  source_sha256 'e704983c3c00e9b76bd836b8b83ce31bfe4eb1752eee8be123cf97c1275076ea'


  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
