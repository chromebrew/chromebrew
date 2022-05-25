require 'package'

class Libdc1394 < Package
  description 'libdc1394 is a library that provides a complete high level application programming interface (API) for developers who wish to control IEEE 1394 based cameras.'
  homepage 'https://damien.douxchamps.net/ieee1394/libdc1394/'
  version '2.2.6'
  compatibility 'all'
  license 'LGPL-2.1'
  source_url 'https://sourceforge.net/projects/libdc1394/files/libdc1394-2/2.2.6/libdc1394-2.2.6.tar.gz'
  source_sha256 '2b905fc9aa4eec6bdcf6a2ae5f5ba021232739f5be047dec8fe8dd6049c10fed'
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdc1394/2.2.6_armv7l/libdc1394-2.2.6-chromeos-armv7l.tpxz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdc1394/2.2.6_armv7l/libdc1394-2.2.6-chromeos-armv7l.tpxz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdc1394/2.2.6_i686/libdc1394-2.2.6-chromeos-i686.tpxz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdc1394/2.2.6_x86_64/libdc1394-2.2.6-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '0b694d5edbf189c0570a497999da69a8d11429f8204ac013d9280a92d1701bcf',
      armv7l: '0b694d5edbf189c0570a497999da69a8d11429f8204ac013d9280a92d1701bcf',
        i686: '9cbbb6aa09c17bf7e68d6638e4121a1d8df5a28bbc28a180f9ca27bef8b84b45',
      x86_64: '778cdfbf6102517458e8c7c5873fb89cf8b13c00ab65ae23cd50de9a1a232adf'
  })

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
