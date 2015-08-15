require 'package'

class Iojs < Package
  version '3.0.0'
  source_url 'https://iojs.org/dist/v3.0.0/iojs-v3.0.0.tar.gz'
  source_sha1 'd5de35b35300b8602ebf6be06ebc0f97de4961f4'

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
