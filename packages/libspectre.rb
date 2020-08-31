require 'package'

class Libspectre < Package
  description 'Small library for rendering Postscript documents'
  homepage 'https://www.freedesktop.org/wiki/Software/libspectre/'
  version '0.2.9'
  compatibility 'all'
  source_url 'https://libspectre.freedesktop.org/releases/libspectre-0.2.9.tar.gz'
  source_sha256 '49ae9c52b5af81b405455c19fe24089d701761da2c45d22164a99576ceedfbed'

  depends_on 'ghostscript' # = libgs

  def self.build
      system "./configure #{CREW_OPTIONS} --disable-static"
      system "make -j#{CREW_NPROC}"
  end
  def self.install
      system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
