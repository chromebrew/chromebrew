require 'package'

class Speex < Package
  version '1.2.0'
  source_url 'http://downloads.us.xiph.org/releases/speex/speex-1.2.0.tar.gz'
  source_sha1 '18ebc3fa3236b4369509e9439acc32d0e864fa7f'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
