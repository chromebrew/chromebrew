require 'package'

class Node < Package
  description 'As an asynchronous event driven JavaScript runtime, Node is designed to build scalable network applications.'
  homepage 'https://nodejs.org/en/'
  version '8.1.0'
  source_url 'https://nodejs.org/dist/v8.1.0/node-v8.1.0.tar.xz'
  source_sha1 '13ed221ed55577beac5203c3c8bfec61af3cad97'

  depends_on 'buildessential'
  depends_on 'python27'

  def self.build
    system "CC='gcc -m64' python2.7 ./configure --without-snapshot"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    #Fix Permissiongs for -g installs of node packages
    #puts  "************************************************************"
    #puts "Now run:"
    #puts "sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}"
    #puts "To be able to do"
    #puts "npm install -g"
    #puts "without being SUDO"
    system "sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}"
  end
end
