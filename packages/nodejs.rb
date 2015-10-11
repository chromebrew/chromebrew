require 'package'

class Nodejs < Package
  version '4.1.2'
  source_url 'https://nodejs.org/dist/v4.1.2/node-v4.1.2.tar.gz'
  source_sha1 '3c901d7b34cf9cc161f6c3845a576fbf0c91b4c5'

  depends_on 'buildessential'
  depends_on 'python27'

  def self.build
    system "CC='gcc' python2.7 ./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
