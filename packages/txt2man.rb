require 'package'

class Txt2man < Package
  version '1.5.6'
  source_url 'http://mvertes.free.fr/download/txt2man-1.5.6.tar.gz'
  source_sha1 'ef1392785333ea88f7e01f4f4c519ecfbdd498bd'

  depends_on 'gawk'
  depends_on 'mandb'

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
