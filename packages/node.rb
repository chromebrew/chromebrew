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
    case ARCH
    when "x86_64"
      system "CC='gcc -m64' python2.7 ./configure --without-snapshot"
    else
      system "CC='gcc' python2.7 ./configure --without-snapshot"
    end
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    #Fix Permissiongs for -g installs of node packages
    system "sudo chown -R chronos /usr/local/{lib/node_modules,bin,share}"
  end
end
