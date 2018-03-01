require 'package'

class Usbutils < Package
  description 'Tools for examining usb devices'
  homepage 'http://linux-usb.sourceforge.net/'
  version '009'
  source_url 'https://www.kernel.org/pub/linux/utils/usb/usbutils/usbutils-009.tar.xz'
  source_sha256 '8bbff0e54cb5f65a52be4feb9162fc0b022a97eb841b44784f7a89a9ea567160'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/usbutils-009-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/usbutils-009-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/usbutils-009-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/usbutils-009-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'de1120c77d3eca02c747435242a8c32c77fb365443a26ca08564f6f34ba2f431',
     armv7l: 'de1120c77d3eca02c747435242a8c32c77fb365443a26ca08564f6f34ba2f431',
       i686: 'c4a9a950367e2d5dedb4b71526a4b8f15e534e7c573d85bc909ded3d1e490d0f',
     x86_64: '8d39c72db131b97b256ef91fc5360479abef2f0be17e785625476d58b8a6aa89',
  })

  depends_on 'libusb'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
