require 'package'

class Libraw1394 < Package
  description 'libraw1394 provides direct access to the IEEE 1394 bus through the Linux 1394 subsystem\'s raw1394 user space interface.'
  homepage 'https://sourceforge.net/projects/libraw1394/'
  version '2.0.5'
  compatibility 'all'
  source_url 'https://downloads.sourceforge.net/project/libraw1394/libraw1394/libraw1394-2.0.5.tar.gz'
  source_sha256 '50e7b812f09ec8181fc060e7e25e260017c16c1b41a04c51e23446f26fa109d4'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libraw1394-2.0.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libraw1394-2.0.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libraw1394-2.0.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libraw1394-2.0.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '80d9eaa85a6bdca66142ccc091e94a1e049d24fb50be4adcaf0656bf136560a2',
     armv7l: '80d9eaa85a6bdca66142ccc091e94a1e049d24fb50be4adcaf0656bf136560a2',
       i686: 'd5701722d2fbb3a2bb7fb4bded4b2635f95a3332cd39a9f5896cd139091e5dcc',
     x86_64: '4c0fd94617c2f7c9cd5c3468b562aa208c6a34812bc05ca63f7c490d298cab84',
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
