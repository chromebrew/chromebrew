require 'package'

class Xinit < Package
  description 'The xinit package contains a usable script to start the xserver'
  homepage 'https://www.x.org'
  version '1.4.0'
  source_url 'https://x.org/pub/individual/app/xinit-1.4.0.tar.bz2'
  source_sha256 '230835eef2f5978a1e1344928168119373f6df1d0a32c09515e545721ee582ef'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xinit-1.4.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xinit-1.4.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xinit-1.4.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xinit-1.4.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '9da0b7a068bd70a97330d1ce90ca457a1554443c0425e4bb27451575ad5d75c4',
     armv7l: '9da0b7a068bd70a97330d1ce90ca457a1554443c0425e4bb27451575ad5d75c4',
       i686: '2c12d81cfe8596cafb010e28a1c37ba1692d52889b78de59c43a91a3bf55f153',
     x86_64: '5df3455157f222c07641d3ff605ff9365fbf4a19d014c2db09999bf84d128296',
  })

  depends_on 'xorg_lib'

  def self.build
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
