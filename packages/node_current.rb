require 'package'

class Node_current < Package
  description 'As an asynchronous event driven JavaScript runtime, Node current is designed to build scalable network applications.'
  homepage 'https://nodejs.org/en/'
  version '7.4.0'
  source_url 'https://nodejs.org/dist/v7.4.0/node-v7.4.0.tar.xz'
  source_sha1 'e31d4d67a6f39ccce2db66dcfa0e6c11851c1375'

  depends_on 'buildessential'
  depends_on 'python27'

  def self.build
    system "CC='gcc' python2.7 ./configure --without-snapshot"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}"
  end
end
