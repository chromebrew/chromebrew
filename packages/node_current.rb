require 'package'

class Node_current < Package
  version '6.9.2'
  source_url 'https://nodejs.org/dist/v6.9.2/node-v6.9.2.tar.gz'
  source_sha1 '6b33b9fac28785b8317dfa5f2402aff2df3e2d5a'

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
