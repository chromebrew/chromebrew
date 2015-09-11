require 'package'

class Nodejs < Package
  version '4.0.0'
  source_url 'https://nodejs.org/dist/v4.0.0/node-v4.0.0.tar.gz'
  source_sha1 'd4791cb483492aea74574f49eee9d6949ecbc759'

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
