require 'package'

class Libraw1394 < Package
  description 'libraw1394 provides direct access to the IEEE 1394 bus through the Linux 1394 subsystem\'s raw1394 user space interface.'
  homepage 'https://sourceforge.net/projects/libraw1394/'
  version '2.0.5-1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/libraw1394/libraw1394/libraw1394-2.0.5.tar.gz'
  source_sha256 '50e7b812f09ec8181fc060e7e25e260017c16c1b41a04c51e23446f26fa109d4'

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
