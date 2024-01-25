require 'package'

class Xorg_fbdev_driver < Package
  description 'The Xorg Fbdev Driver package contains the X.Org Video Driver for framebuffer devices. This driver is often used as fallback driver if the hardware specific and VESA drivers fail to load or are not present.'
  homepage 'https://www.x.org'
  version '0.4.4'
  license 'MIT-with-advertising'
  compatibility 'all'
  source_url 'https://www.x.org/pub/individual/driver/xf86-video-fbdev-0.4.4.tar.bz2'
  source_sha256 '9dd4b326498223abbfdf786089a46ea3db4fa6bbd341308eb48a9e00bc3fd51b'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: '430546814a47a8471548d568adda055a85ac52b2b5c86a399d23dc2b1b887ee2',
     armv7l: '430546814a47a8471548d568adda055a85ac52b2b5c86a399d23dc2b1b887ee2',
       i686: '645cc4317fc56a716324224cbd9e20e2b42865e4c3bbeccb7cc113739b52b1b7',
     x86_64: '3dbeadf9bf8753c28c9950a9ce6d45583e52e8ad0e629caf422ba62968985137'
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
