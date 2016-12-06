require 'package'

class Node_stable < Package
  version '6.2.2'
  source_url 'https://nodejs.org/dist/v6.2.2/node-v6.2.2.tar.xz'
  source_sha1 '2dfeeddba750b52a528b38a1c31e35c1fb40b19cf28fbf430c3c8c7a6517005a'

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
