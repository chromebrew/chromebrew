require 'package'

class Libsm < Package
  description 'X.org X Session Management Library'
  homepage 'http://www.x.org'
  version '1.2.3'
  license 'MIT'
  compatibility 'all'
  source_url 'https://www.x.org/archive/individual/lib/libSM-1.2.3.tar.gz'
  source_sha256 '1e92408417cb6c6c477a8a6104291001a40b3bb56a4a60608fdd9cd2c5a0f320'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsm/1.2.3_armv7l/libsm-1.2.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsm/1.2.3_armv7l/libsm-1.2.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsm/1.2.3_i686/libsm-1.2.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsm/1.2.3_x86_64/libsm-1.2.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7d6702a3ba19eae8a974a69614c262f50ae7c6f7b1b514bd52591131192bb086',
     armv7l: '7d6702a3ba19eae8a974a69614c262f50ae7c6f7b1b514bd52591131192bb086',
       i686: '8ecb14d2b98abcb482d222fabcb04e036525ae02e29556ee0f5ec6632403a7b6',
     x86_64: 'f994171ce6971904dbba890e78e2a95db68c99c0509730e62cb53f6ef71ce88a'
  })

  depends_on 'libice'
  depends_on 'libx11'
  patchelf

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
