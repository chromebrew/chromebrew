require 'package'

class Di < Package
  description '\'di\' is a disk information utility, displaying everything (and more) that your \'df\' command does.'
  homepage 'http://gentoo.com/di/'
  version '4.47.1'
  compatibility 'all'
  source_url 'https://gentoo.com/di/di-4.47.1.tar.gz'
  source_sha256 'eea8ad94197d9f11790afea0924d8bf29ec001c32eb6209e81c4e13766a2abad'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/di-4.47.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/di-4.47.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/di-4.47.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/di-4.47.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7f6339ca083956c06ae62710e486cdb49a9fb9d5448ca1332fea57fe0d29a029',
     armv7l: '7f6339ca083956c06ae62710e486cdb49a9fb9d5448ca1332fea57fe0d29a029',
       i686: '3f3972ee14f7d38953afe50f6b5889cabad4e532264df79ab47c83ce62775874',
     x86_64: '38e6c521776e089729a29b43dbb24e142614edb7e88e077cc69f81dbe0136ff7',
  })

  def self.build
    system "sed -i 's,prefix = /usr/local,prefix = #{CREW_DEST_PREFIX},' Makefile"
    system "sed -i 's,USER = root,USER = #{USER},' Makefile" # set correct owner
    system "sed -i 's,GROUP = bin,GROUP = #{USER},' Makefile" # set correct group
    system 'make -e dioptions.dat'
    system 'make -e'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "-e", "install"
  end
end
