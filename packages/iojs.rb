require 'package'

class Iojs < Package
  version '2.2.1'
  source_url 'https://iojs.org/dist/v2.2.1/iojs-v2.2.1.tar.gz'
  source_sha1 '2b4a43cc1333526cbc5ac2e30d765a4d9c26427c'

  depends_on 'buildessential'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
