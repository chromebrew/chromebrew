require 'package'

class Acl < Package
  description 'Commands for Manipulating POSIX Access Control Lists.'
  homepage 'http://savannah.nongnu.org/projects/acl'
  version '2.3.1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://bigsearcher.com/mirrors/nongnu/acl/acl-2.3.1.tar.xz'
  source_sha256 'c0234042e17f11306c23c038b08e5e070edb7be44bef6697fb8734dcff1c66b1'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/acl/2.3.1_armv7l/acl-2.3.1-chromeos-armv7l.tpxz',
    armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/acl/2.3.1_armv7l/acl-2.3.1-chromeos-armv7l.tpxz',
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/acl/2.3.1_i686/acl-2.3.1-chromeos-i686.tpxz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/acl/2.3.1_x86_64/acl-2.3.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '53eddf80135a3265f01a90ffd9b71c9453b95d432260aea6d8331514fe4af2eb',
    armv7l: '53eddf80135a3265f01a90ffd9b71c9453b95d432260aea6d8331514fe4af2eb',
    i686: 'e96e13e6cce5e572a12e9aa3b1e0190fb8cb95712492dfe219aa3b7c69c971e8',
    x86_64: 'ced96737007afe57d6ee741165e8c409ad2ea8bb361b8356197d1bd4f2c782c0'
  })

  depends_on 'attr'

  def self.patch
    system 'filefix'
  end

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
