require 'package'

class Nodejs < Package
  version '4.2.2'
  source_url 'https://nodejs.org/dist/v4.2.2/node-v4.2.2.tar.xz'
  source_sha1 '3591ea7a464500b68e01a09c293946f73faf8514'

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
