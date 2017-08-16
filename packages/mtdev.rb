require 'package'

class Mtdev < Package
  description 'The mtdev is a stand-alone library which transforms all variants of kernel MT events to the slotted type B protocol.'
  homepage 'http://bitmath.org/code/mtdev'
  version '1.1.5'
  source_url 'http://bitmath.org/code/mtdev/mtdev-1.1.5.tar.bz2'
  source_sha256 '6677d5708a7948840de734d8b4675d5980d4561171c5a8e89e54adf7a13eba7f'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
