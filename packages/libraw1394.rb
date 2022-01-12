require 'package'

class Libraw1394 < Package
  description 'libraw1394 provides direct access to the IEEE 1394 bus through the Linux 1394 subsystem\'s raw1394 user space interface.'
  homepage 'https://sourceforge.net/projects/libraw1394/'
  version '2.0.5-1'
  compatibility 'all'
  license 'LGPL-2.1'
  source_url 'https://downloads.sourceforge.net/project/libraw1394/libraw1394/libraw1394-2.0.5.tar.gz'
  source_sha256 '50e7b812f09ec8181fc060e7e25e260017c16c1b41a04c51e23446f26fa109d4'

  binary_url ({
     aarch64: 'file:///usr/local/tmp/packages/libraw1394-2.0.5-1-chromeos-armv7l.tpxz',
      armv7l: 'file:///usr/local/tmp/packages/libraw1394-2.0.5-1-chromeos-armv7l.tpxz',
        i686: 'file:///usr/local/tmp/packages/libraw1394-2.0.5-1-chromeos-i686.tpxz',
      x86_64: 'file:///usr/local/tmp/packages/libraw1394-2.0.5-1-chromeos-x86_64.tpxz',
  })
  binary_sha256 ({
     aarch64: '89c4930bdff2cf21ee6c7b89221da7fb7140b414769f3ba387d435bf0d9e39c4',
      armv7l: '89c4930bdff2cf21ee6c7b89221da7fb7140b414769f3ba387d435bf0d9e39c4',
        i686: '4ba228574aef58ffecf52343fe0775458222e5228fc7e38ba65a70554c49af6f',
      x86_64: 'b7cc279e24024fcc74df606f7fe33518902ab67531838caf165f2ed3cd23f12d',
  })

  def self.build
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
