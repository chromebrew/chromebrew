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
    
    # Fix Permissiongs for -g installs of node packages
    system "sudo chown -R chronos /usr/local/bin"
    system "sudo chown -R chronos /usr/local/share"
    if Dir.exists?('/usr/local/lib/node_modules')
      system "sudo chown -R chronos /usr/local/lib/node_modules"
    end
  end
end
