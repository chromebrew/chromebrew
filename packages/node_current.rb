require 'package'

class Node_current < Package
  version '6.3.1'
  source_url 'https://nodejs.org/dist/v6.3.1/node-v6.3.1.tar.xz'
  source_sha1 '7021da27637f0e099598f0a7e8ddaf07e8bb3a69'

  depends_on 'buildessential'
  depends_on 'python27'

  depends_on 'openssl_devel'

  def self.build
    system "CC='gcc' python2.7 ./configure --without-snapshot"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    #Fix Permissiongs for -g installs of node packages
    system "echo 'Now to get npm -g working you should type this'" 
    system "echo 'sudo chown -R chronos /usr/local/lib/node_modules'"
  end
end
