require 'package'

class Libunwind < Package
  version '1.1'
  source_url 'http://download.savannah.gnu.org/releases/libunwind/libunwind-1.1.tar.gz'
  source_sha1 '7c93a6ae35afff4d0efd143b62a9fd235423964f'

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
