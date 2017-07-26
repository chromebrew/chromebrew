require 'package'

class Libxfixes < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '5.0.3'
  source_url 'https://www.x.org/archive/individual/lib/libXfixes-5.0.3.tar.gz'
  source_sha256 '9ab6c13590658501ce4bd965a8a5d32ba4d8b3bb39a5a5bc9901edffc5666570'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
