require 'package'

class Xcb_proto < Package
  description 'The protocols for the X window system provide extended functionality for communication between a X client and the server.'
  homepage 'https://xcb.freedesktop.org'
  version '1.14.1-1'
  license 'MIT-with-advertising'
  compatibility 'all'
  source_url 'https://x.org/releases/individual/proto/xcb-proto-1.14.1.tar.xz'
  source_sha256 'f04add9a972ac334ea11d9d7eb4fc7f8883835da3e4859c9afa971efdf57fcc3'

  def self.build
    system 'NOCONFIGURE=1 ./autogen.sh'
    system "#{CREW_ENV_OPTIONS} ./autogen.sh #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
