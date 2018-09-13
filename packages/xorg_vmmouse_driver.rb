require 'package'

class Xorg_vmmouse_driver < Package
  description 'The Xorg VMMouse Driver package contains the VMMouse input driver for the Xorg X server. The VMMouse driver enables support for the special VMMouse protocol that is provided by VMware virtual machines to give absolute pointer positioning.'
  homepage 'https://www.x.org'
  version '13.1.0'
  source_url 'https://www.x.org/pub/individual/driver/xf86-input-vmmouse-13.1.0.tar.bz2'
  source_sha256 '0af558957ac1be1b2863712c2475de8f4d7f14921fd01ded2e2fde4921b19319'

  binary_url ({
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_vmmouse_driver-13.1.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_vmmouse_driver-13.1.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
       i686: '8c58a01d23d1a4dfc99227a9353a714ef8d317446e934d1c69adb7a151d69806',
     x86_64: 'fafabffe2375b86cc48e6351767f37c61bf67739a3182647ea3a2393aee5b3d1',
  })

  depends_on 'xorg_server' => :build

  # Only for x86 architecture

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
