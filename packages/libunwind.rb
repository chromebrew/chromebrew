require 'package'

class Libunwind < Package
  version '1.1'
  source_url 'http://download.savannah.gnu.org/releases/libunwind/libunwind-1.1.tar.gz'
  source_sha1 '07ea3c55e67e26fb7a2ab00ecc67c9e80130ad42'

  depends_on 'buildessential'
  depends_on 'openssl'

  def self.build
    system "CC='gcc' ./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
