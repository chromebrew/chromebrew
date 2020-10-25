require 'package'

class Libxinerama < Package
  description 'Xorg library, Xinerama is an X11 extension which provides support for extending a desktop across multiple displays.'
  homepage 'https://www.x.org/'
  compatibility 'all'
  version '1.1.4'
  source_url 'https://www.x.org/archive/individual/lib/libXinerama-1.1.4.tar.bz2'
  source_sha256 '0008dbd7ecf717e1e507eed1856ab0d9cf946d03201b85d5dcf61489bb02d720'

  depends_on 'libx11'
  depends_on 'libxcb'
  depends_on 'libxext'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

end
