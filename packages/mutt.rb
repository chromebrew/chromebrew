require 'package'

class Mutt < Package
  description 'Mutt is a small but very powerful text-based mail client for Unix operating systems.'
  homepage 'http://mutt.org/'
  version '1.9.1'
  source_url 'ftp://ftp.mutt.org/pub/mutt/mutt-1.9.1.tar.gz'
  source_sha256 '749b83a96373c6e2101ebe8c4b9a651735e02c478edb750750a5146a15d91bb1'

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
