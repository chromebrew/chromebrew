require 'package'

class Libxfont < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '2.0.1'
  source_url 'https://www.x.org/archive/individual/lib/libXfont2-2.0.1.tar.gz'
  source_sha256 '381b6b385a69343df48a082523c856aed9042fbbc8ee0a6342fb502e4321230a'

  depends_on 'libfontenc'
  depends_on 'freetype'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
