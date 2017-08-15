require 'package'

class Node_current < Package
  description 'As an asynchronous event driven JavaScript runtime, Node is designed to build scalable network applications.'
  homepage 'https://nodejs.org/en/'
  version '8.1.2'
  source_url 'https://nodejs.org/dist/v8.1.2/node-v8.1.2.tar.gz'
  source_sha256 'd717b364868956e0b775145e57a84e63962a9cf83146e778547fc71bb27a2251'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/node_current-8.1.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/node_current-8.1.2-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/node_current-8.1.2-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/node_current-8.1.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4b7466db145427111a405ab563b906ceca53e309476188d46f6448b87dcfa8b4',
     armv7l: '4b7466db145427111a405ab563b906ceca53e309476188d46f6448b87dcfa8b4',
       i686: 'c12c4f01b4fe678355a6f8abe3b46a2b66b90c7ef650c57df9031272251f90ff',
     x86_64: 'c84f9f9a7b57be96795c149307d510c7b71bc81449f0805e8458c0ce701cedc3',
  })

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
