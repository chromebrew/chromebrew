require 'package'

class Netpbm < Package
  description 'Netpbm is a toolkit for manipulation of graphic images, including conversion of images between a variety of different formats.'
  homepage 'http://netpbm.sourceforge.net/'
  version '10.73.28'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/netpbm/super_stable/10.73.28/netpbm-10.73.28.tgz'
  source_sha256 'c0d32d4b9a53fde47dd9a36f45653e0ef51f6c390517f10b0c5056d1a8a844bd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/netpbm-10.73.28-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/netpbm-10.73.28-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/netpbm-10.73.28-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/netpbm-10.73.28-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2f4dd0de3f9af1423121ba6e82ddc268863fadaf50222a51dc2026652e99fefb',
     armv7l: '2f4dd0de3f9af1423121ba6e82ddc268863fadaf50222a51dc2026652e99fefb',
       i686: '3a900cd5917c750a09f5d9e5f5845c2cfe1a02539c3ad8ef63d0a291ea0f1c64',
     x86_64: '06375d9b711b7a03a26e8d00d84c3a13f3d1c2bc3cff16442c39b29c7ca2a58f',
  })

  depends_on 'libtiff'

  def self.patch
    system "sed -i 's,/etc/,#{CREW_DEST_PREFIX}/etc/,g' buildtools/installnetpbm.pl"
  end

  def self.build
    puts
    puts 'This is the dumbest thing but when prompted, hit enter for every prompt.'.lightblue
    system './configure'
    system 'make'
    system 'make package'
  end

  def self.install
    puts
    puts "When prompted for install prefix, enter '#{CREW_DEST_PREFIX}', otherwise hit enter for every other prompt.".lightblue
    puts
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/etc"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share"
    system './installnetpbm'
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,' #{CREW_DEST_PREFIX}/bin/manweb"
    system "sed -i 's,/etc/manweb.conf,#{CREW_PREFIX}/etc/manweb.conf,' #{CREW_DEST_PREFIX}/bin/manweb"
    FileUtils.mv "#{CREW_DEST_PREFIX}/man", "#{CREW_DEST_PREFIX}/share"
    FileUtils.mv "#{CREW_DEST_PREFIX}/lib", "#{CREW_DEST_LIB_PREFIX}" if ARCH == 'x86_64'
    FileUtils.rm_f '/tmp/netpbm'
  end
end
