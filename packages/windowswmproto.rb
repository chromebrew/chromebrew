require 'package'

class Windowswmproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage ''
  version '1.0.4'
  source_url 'https://www.x.org/archive/individual/proto/windowswmproto-1.0.4.tar.gz'
  source_sha256 '2dccf510cf18a1b5cfd3a277c678d88303efc85478b479fec46228a861956eb7'

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
