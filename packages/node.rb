require 'package'

class Nodejs < Package
  version '4.2.4'
  source_url 'https://nodejs.org/dist/v4.2.6/node-v4.2.6.tar.xz'
  source_sha1 'c6f2f33ec05b3ed1ead3b995a8c4485b33f8855e'

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
