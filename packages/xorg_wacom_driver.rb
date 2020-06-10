require 'package'

class Xorg_wacom_driver < Package
  description 'The Xorg Wacom Driver package contains the X.Org X11 driver and SDK for Wacom and Wacom-like tablets. It is not required to use a Wacom tablet, the xf86-input-evdev driver can handle these devices without problems.'
  homepage 'https://www.x.org'
  version '0.36.0'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/linuxwacom/xf86-input-wacom-0.36.0.tar.bz2'
  source_sha256 'eae7c5d2872b1433c8d679bb42b00213403eb2a0544c514f4df2b586284c23f6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_wacom_driver-0.36.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_wacom_driver-0.36.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_wacom_driver-0.36.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/xorg_wacom_driver-0.36.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ee29a6cace73be6ba1a7d219ad1b177a27329b60bd54ac535bcf542810e49f17',
     armv7l: 'ee29a6cace73be6ba1a7d219ad1b177a27329b60bd54ac535bcf542810e49f17',
       i686: 'b626188aa89986e4440c8a549bfd3b96805c97b7bd7e243a129ebe86eddb17c1',
     x86_64: 'bb728fe3c71174876921f48677d5c796a44789d42f919f4169bc64ad08757258',
  })

  depends_on 'xorg_server' => :build

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-shared',
           '--disable-static',
           '--with-systemd-unit-dir=no'
    system 'make'
  end

  def self.check
    system "make -j#{CREW_NPROC} check"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install-strip'
  end
end
