require 'package'

class Node_current < Package
  description 'As an asynchronous event driven JavaScript runtime, Node is designed to build scalable network applications.'
  homepage 'https://nodejs.org/en/'
  version '8.1.2'
  source_url 'https://nodejs.org/dist/v8.1.2/node-v8.1.2.tar.gz'
  source_sha1 'e80d3e6ae766349a925911f0a8e5533827c58673'

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

    # Fix Permissiongs for -g installs of node packages
    system "sudo chown -R chronos /usr/local/bin"
    system "sudo chown -R chronos /usr/local/share"
    if Dir.exists?('/usr/local/lib/node_modules')
      system "sudo chown -R chronos /usr/local/lib/node_modules"                                  
    end
  end
end
