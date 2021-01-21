require 'package'

class Xorg_vmware_driver < Package
  description 'The Xorg VMware Driver package contains the X.Org Video Driver for VMware SVGA virtual video cards.'
  homepage 'https://01.org/linuxgraphics/'
  version '13.2.1'
  compatibility 'all'
  source_url 'https://www.x.org/pub/individual/driver/xf86-video-vmware-13.2.1.tar.bz2'
  source_sha256 'e2f7f7101fba7f53b268e7a25908babbf155b3984fb5268b3d244eb6c11bf62b'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_vmware_driver-13.2.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_vmware_driver-13.2.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_vmware_driver-13.2.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_vmware_driver-13.2.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '23546757562958f739b4121ba98cb3324ab32687d073bdd6a0d868ee993a0bc1',
     armv7l: '23546757562958f739b4121ba98cb3324ab32687d073bdd6a0d868ee993a0bc1',
       i686: '3ee148b38ba1ac371227ce7a121b03d97aa77895d0b9e02a8d5a0bc9f6e449d9',
     x86_64: '2f4c4dd3532057e2fa8bdfc6f09427987e840696eae2464a9806dcaac315aac8',
  })

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
