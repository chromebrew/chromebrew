require 'package'

class Xcb_proto < Package
  description ''
  homepage ''
  version '1.12'
  source_url 'https://www.x.org/archive/individual/xcb/xcb-proto-1.12.tar.gz'
  source_sha256 'cfa49e65dd390233d560ce4476575e4b76e505a0e0bacdfb5ba6f8d0af53fd59'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
