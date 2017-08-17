require 'package'

class Fontcacheproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://x.org'
  version '0.13'
  source_url 'https://www.x.org/archive/individual/proto/fontcacheproto-0.1.3.tar.gz'
  source_sha256 '759b4863b55a25bfc8f977d8ed969da0b99b3c823f33c674d6da5825f9df9a79'

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
