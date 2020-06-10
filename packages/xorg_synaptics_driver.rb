require 'package'

class Xorg_synaptics_driver < Package
  description 'The Xorg Synaptics Driver package contains the X.Org Input Driver, support programs and SDK for Synaptics touchpads.'
  homepage 'https://www.x.org'
  version '1.9.0'
  compatibility 'all'
  source_url 'https://www.x.org/pub/individual/driver/xf86-input-synaptics-1.9.0.tar.bz2'
  source_sha256 'afba3289d7a40217a19d90db98ce181772f9ca6d77e1898727b0afcf02073b5a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_synaptics_driver-1.9.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_synaptics_driver-1.9.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_synaptics_driver-1.9.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_synaptics_driver-1.9.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '455fe9b17ba1b46407680ad3c5c4f21ba2ff4db55578d3144fcfe38d844980dc',
     armv7l: '455fe9b17ba1b46407680ad3c5c4f21ba2ff4db55578d3144fcfe38d844980dc',
       i686: '98044f62dd0086f390d229b7b829a1d4347674a13c02a6aff24a52a2fc04622c',
     x86_64: '20281d2dadaed44efd343a85e889b24062bdf9532354757ca266ba621931782a',
  })

  depends_on 'libevdev'
  depends_on 'xorg_server' => :build

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-shared',
           '--disable-static'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-strip'
  end
end
