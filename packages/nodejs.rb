require 'package'

class Nodejs < Package
  version '4.2.3'
  source_url 'https://nodejs.org/dist/v4.2.3/node-v4.2.3.tar.xz'
  source_sha1 '95c7b2aa36fcad2cb6513ca7f1af191ec95826da'

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
