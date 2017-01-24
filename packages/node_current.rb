require 'package'

class Node_current < Package
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
    #Fix Permissiongs for -g installs of node packages
    puts  "************************************************************"
    puts "Now run:"
    puts "sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}"
    puts "To be able to do"
    puts "npm install -g"
    puts "without being SUDO"
  end
end
