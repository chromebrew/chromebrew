require 'package'

class Attr < Package
  description 'Commands for Manipulating Filesystem Extended Attributes.'
  homepage 'http://savannah.nongnu.org/projects/attr'
  version '2.5.1-1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/attr/attr-2.5.1.tar.xz'
  source_sha256 'db448a626f9313a1a970d636767316a8da32aede70518b8050fa0de7947adc32'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/attr/2.5.1-1_armv7l/attr-2.5.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/attr/2.5.1-1_armv7l/attr-2.5.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/attr/2.5.1-1_i686/attr-2.5.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/attr/2.5.1-1_x86_64/attr-2.5.1-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '064c27a5daaecabe639c40b1b307bdc7711e7132903d300de699219dc8d00685',
     armv7l: '064c27a5daaecabe639c40b1b307bdc7711e7132903d300de699219dc8d00685',
       i686: 'fb434974fc3a48c3122785de09515115762555e9c7551db8734e54f251db6c51',
     x86_64: '690156378a76ac649c3fd780c517042f74ef812da45e9f84274b2ce5e80b3978'
  })

  depends_on 'libcap' => :build
  no_zstd

  def self.build
    system "./configure \
      #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
