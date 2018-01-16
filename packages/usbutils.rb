require 'package'

class Usbutils < Package
  description 'Tools for examining usb devices'
  homepage 'http://linux-usb.sourceforge.net/'
  version '009'
  source_url 'https://www.kernel.org/pub/linux/utils/usb/usbutils/usbutils-009.tar.xz'
  source_sha256 '8bbff0e54cb5f65a52be4feb9162fc0b022a97eb841b44784f7a89a9ea567160'

  binary_url ({
  })
  binary_sha256 ({
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
