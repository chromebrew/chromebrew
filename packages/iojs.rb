require 'package'

class Iojs < Package
  version '2.4.0'
  source_url 'https://iojs.org/dist/v2.4.0/iojs-v2.4.0.tar.gz'
  source_sha1 'ec273ab80421126c304a6910d8780cae4cbc1276'

  depends_on 'buildessential'
  depends_on 'python27'

  def self.build
    system "CC='gcc' ./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
