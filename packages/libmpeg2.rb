require 'package'

class Libmpeg2 < Package
  description 'A free MPEG-2 video stream decoder'
  homepage 'https://libmpeg2.sourceforge.io/'
  version '0.5.1'
  compatibility 'all'
  source_url 'https://libmpeg2.sourceforge.io/files/libmpeg2-0.5.1.tar.gz'
  source_sha256 'dee22e893cb5fc2b2b6ebd60b88478ab8556cb3b93f9a0d7ce8f3b61851871d4'

  depends_on 'libx11'
  depends_on 'imake' => :build

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --with-x"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
