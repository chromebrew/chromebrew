require 'package'

class Attr < Package
  description 'Commands for Manipulating Filesystem Extended Attributes.'
  homepage 'http://savannah.nongnu.org/projects/attr'
  version '2.5.1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://download.savannah.gnu.org/releases/attr/attr-2.5.1.tar.xz'
  source_sha256 'db448a626f9313a1a970d636767316a8da32aede70518b8050fa0de7947adc32'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/attr/2.5.1_armv7l/attr-2.5.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/attr/2.5.1_armv7l/attr-2.5.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/attr/2.5.1_i686/attr-2.5.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/attr/2.5.1_x86_64/attr-2.5.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'da212fa1e85d525d438aa7c0a63ff094d158f241c8f359bad17e4c0932b1b5fa',
     armv7l: 'da212fa1e85d525d438aa7c0a63ff094d158f241c8f359bad17e4c0932b1b5fa',
       i686: '13b8ad2172c3cd53e1670a8c9fe890ce9c72b3291f24392b4690ad656c969e61',
     x86_64: '8f78f7cede30f6be0035f3c3a51a0323e94c7e74dc907302abaf04bc4d3a5ccd'
  })

  def self.build
    system "env #{CREW_ENV_OPTIONS} \
      ./configure \
      #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
