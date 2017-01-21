require 'package'

class Node < Package
  version '6.9.4'
  source_url 'https://nodejs.org/dist/v6.9.4/node-v6.9.4.tar.gz'
  source_sha1 '3b798acf7af4cd3f0efdb86bea009794492129ba'

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
