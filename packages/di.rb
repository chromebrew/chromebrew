require 'package'

class Di < Package
  description '\'di\' is a disk information utility, displaying everything (and more) that your \'df\' command does.'
  homepage 'http://gentoo.com/di/'
  version '4.47.1'
  source_url 'https://gentoo.com/di/di-4.47.1.tar.gz'
  source_sha256 'eea8ad94197d9f11790afea0924d8bf29ec001c32eb6209e81c4e13766a2abad'

  binary_url ({
  })
  binary_sha256 ({
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
