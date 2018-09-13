require 'package'

class Xorg_vmware_driver < Package
  description 'The Xorg VMware Driver package contains the X.Org Video Driver for VMware SVGA virtual video cards.'
  homepage 'https://01.org/linuxgraphics/'
  version '13.2.1'
  source_url 'https://www.x.org/pub/individual/driver/xf86-video-vmware-13.2.1.tar.bz2'
  source_sha256 'e2f7f7101fba7f53b268e7a25908babbf155b3984fb5268b3d244eb6c11bf62b'

  binary_url ({
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_vmware_driver-13.2.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_vmware_driver-13.2.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
       i686: '9929860a25a5d16ddfcbdf2a9ca831a9200ae954b00b74bfa2b56c730207f32c',
     x86_64: '2132d4e80ca1f1f8c18d777e240067bc96f6833234941115c682980fcca3e67e',
  })

  depends_on 'xorg_server' => :build
  
  def self.build
    system "./configure",
             "--prefix=#{CREW_PREFIX}",
             "--libdir=#{CREW_LIB_PREFIX}",
             "--enable-shared",
             "--disable-static"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"
  end
end
