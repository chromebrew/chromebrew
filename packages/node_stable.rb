require 'package'

class Node_stable < Package
  version '5.6.0'
  source_url 'https://nodejs.org/dist/v5.6.0/node-v5.6.0.tar.xz'
  source_sha1 '522b4f1027549eb8161c1edba222176aba92e294'

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
