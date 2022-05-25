require 'package'

class Libraw1394 < Package
  description 'libraw1394 provides direct access to the IEEE 1394 bus through the Linux 1394 subsystem\'s raw1394 user space interface.'
  homepage 'https://sourceforge.net/projects/libraw1394/'
  version '2.0.5-1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/libraw1394/libraw1394/libraw1394-2.0.5.tar.gz'
  source_sha256 '50e7b812f09ec8181fc060e7e25e260017c16c1b41a04c51e23446f26fa109d4'
  binary_compression 'tpxz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libraw1394/2.0.5-1_armv7l/libraw1394-2.0.5-1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libraw1394/2.0.5-1_armv7l/libraw1394-2.0.5-1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libraw1394/2.0.5-1_i686/libraw1394-2.0.5-1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libraw1394/2.0.5-1_x86_64/libraw1394-2.0.5-1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f98d25737550b990177048ca94b6bfbc262c1029bece77c27885053070e9bcae',
     armv7l: 'f98d25737550b990177048ca94b6bfbc262c1029bece77c27885053070e9bcae',
       i686: '53af9bb5729d454481705f5d7f8b4f1cb69178cb1955da7392f52e334cf6cd4c',
     x86_64: '874f0550d05403d7b90c448430c82fab2490a61d826c7b9d1c49aeb7441f1476'
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
