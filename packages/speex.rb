require 'package'

class Speex < Package
  description 'Speex is an Open Source/Free Software patent-free audio compression format designed for speech.'
  homepage 'https://speex.org/'
  version '1.2.0'
  source_url 'http://downloads.us.xiph.org/releases/speex/speex-1.2.0.tar.gz'
  source_sha256 'eaae8af0ac742dc7d542c9439ac72f1f385ce838392dc849cae4536af9210094'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
