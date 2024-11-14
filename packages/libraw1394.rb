require 'buildsystems/autotools'

class Libraw1394 < Autotools
  description 'libraw1394 provides direct access to the IEEE 1394 bus through the Linux 1394 subsystem\'s raw1394 user space interface.'
  homepage 'https://sourceforge.net/projects/libraw1394/'
  version '2.1.2'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url "https://www.kernel.org/pub/linux/libs/ieee1394/libraw1394-#{version}.tar.xz"
  source_sha256 '03ccc69761d22c7deb1127fc301010dd13e70e44bb7134b8ff0d07590259a55e'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c275175e2e4e8be4fa817d3398faf415ccdd74bb37b0d4e856f6381dedae5cc4',
     armv7l: 'c275175e2e4e8be4fa817d3398faf415ccdd74bb37b0d4e856f6381dedae5cc4',
       i686: '9bee6317419d78c8497fce66f5f2e6c35d4dd124a206d3d32d618601a5f82c79',
     x86_64: '11474a36fe379f1a95f3280d0dfa0ae6453c1ef030197571dd48210e76c20c43'
  })

  run_tests
end
