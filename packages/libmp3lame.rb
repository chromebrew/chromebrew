require 'package'

class Libmp3lame < Package
  description 'LAME is a high quality MPEG Audio Layer III (MP3) encoder licensed under the LGPL.'
  homepage 'http://lame.sourceforge.net/'
  version '3.99.5'
  source_url 'https://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz'
  source_sha1 '03a0bfa85713adcc6b3383c12e2cc68a9cfbf4c4'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
