require 'package'

class Libdc1394 < Package
  description 'libdc1394 is a library that provides a complete high level application programming interface (API) for developers who wish to control IEEE 1394 based cameras.'
  homepage 'https://damien.douxchamps.net/ieee1394/libdc1394/'
  version '2.2.6'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://sourceforge.net/projects/libdc1394/files/libdc1394-2/2.2.6/libdc1394-2.2.6.tar.gz'
  source_sha256 '2b905fc9aa4eec6bdcf6a2ae5f5ba021232739f5be047dec8fe8dd6049c10fed'

  depends_on 'freeglut'
  depends_on 'libraw1394'
  depends_on 'libusb'

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
