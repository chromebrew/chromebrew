require 'package'

class Xcmiscproto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage ''
  version '1.2.2'
  source_url 'https://www.x.org/archive/individual/proto/xcmiscproto-1.2.2.tar.gz'
  source_sha256 '48013cfbe4bd5580925a854a43e2bccbb4c7a5a31128070644617b6dc7f8ef85'

  def self.build
    system "./configure"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
