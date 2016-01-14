require 'package'

class Nodejs < Package
  version '4.2.4'
  source_url 'https://nodejs.org/dist/v4.2.4/node-v4.2.4.tar.gz'
  source_sha1 '3cfef84f3a80b9e8835f8bee5a8209a4af8c52f2'

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
