require 'package'

class Node < Package
  description 'As an asynchronous event driven JavaScript runtime, Node is designed to build scalable network applications.'
  homepage 'https://nodejs.org/en/'
  version '6.11.0'
  source_url 'https://nodejs.org/dist/v6.11.0/node-v6.11.0.tar.xz'
  source_sha1 '1e408d9981606c5a01f46b4b6c93c0b30fa49d8c'

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
