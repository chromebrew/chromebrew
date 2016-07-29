require 'package'

class Node < Package
  version '4.4.5'
  source_url 'https://nodejs.org/dist/v4.4.5/node-v4.4.5.tar.xz'
  source_sha1 'be0af595facab8be2dd8fa64c051c4c5a7ec0c4a'

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
