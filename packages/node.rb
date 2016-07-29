require 'package'

class Node < Package
  version '4.4.7'
  source_url 'https://nodejs.org/dist/v4.4.7/node-v4.4.7.tar.xz'
  source_sha1 'a39d03d04a79af2220ca94a8735e7acbe180c4e5'

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
