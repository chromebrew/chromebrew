require 'package'

class Mutt < Package
  description 'Mutt is a small but very powerful text-based mail client for Unix operating systems.'
  homepage 'http://mutt.org/'
  version '1.9.2'
  source_url 'ftp://ftp.mutt.org/pub/mutt/mutt-1.9.2.tar.gz'
  source_sha256 'a2e152a352bbf02d222d54074199d9c53821c19f700c4cb85f78fa85faed7896'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libxslt'

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --with-mailpath=#{CREW_PREFIX}/mail"
    system 'make'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/mail"
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
