require 'package'

class Node < Package
  description 'As an asynchronous event driven JavaScript runtime, Node is designed to build scalable network applications.'
  homepage 'https://nodejs.org/en/'
  version '6.11.0'
  source_url 'https://nodejs.org/dist/v6.11.0/node-v6.11.0.tar.xz'
  source_sha256 '02ba35391edea2b294c736489af01954ce6e6c39d318f4423ae6617c69ef0a51'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/node-6.11.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/node-6.11.0-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/node-6.11.0-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/node-6.11.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'aaf48e60fda219b5ad14ef7dedf7501e8c70680314efcc6d7e4945f94be494ee',
     armv7l: 'aaf48e60fda219b5ad14ef7dedf7501e8c70680314efcc6d7e4945f94be494ee',
       i686: 'dca9ae324867bafd064af03f214a0e9b3f94d77a17a6a8bb0a09429c0c2b9f75',
     x86_64: '364667aca8e8a4931a3b0ef83a2870ceadf659b81b0177d8faa77efc1521ce7c',
  })

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
