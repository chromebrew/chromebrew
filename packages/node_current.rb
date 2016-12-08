require 'package'

class Node_current < Package
  version '6.2.2'
  source_url 'https://nodejs.org/dist/v6.2.2/node-v6.2.2.tar.xz'
  source_sha1 '5014800813fa3682b8053637518b37a119c26e93'

  depends_on 'buildessential'
  depends_on 'python27'

  def self.build
    system "CC='gcc' python2.7 ./configure --without-snapshot"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    #Fix Permissiongs for -g installs of node packages
    system "sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}"
  end
end
