require 'package'

class Libxdamage < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  @_ver = '1.1.5'
  version @_ver
  license 'MIT'
  compatibility 'all'
  source_url "https://www.x.org/archive/individual/lib/libXdamage-#{@_ver}.tar.gz"
  source_sha256 '630ec53abb8c2d6dac5cd9f06c1f73ffb4a3167f8118fdebd77afd639dbc2019'

  binary_url ({
     aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxdamage/1.1.5_armv7l/libxdamage-1.1.5-chromeos-armv7l.tar.xz',
      armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxdamage/1.1.5_armv7l/libxdamage-1.1.5-chromeos-armv7l.tar.xz',
        i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxdamage/1.1.5_i686/libxdamage-1.1.5-chromeos-i686.tar.xz',
      x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libxdamage/1.1.5_x86_64/libxdamage-1.1.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '1732f53c0dadda7fbc3a17b9628930e3f5a5c22200cc0d8e6020eca7f410264b',
      armv7l: '1732f53c0dadda7fbc3a17b9628930e3f5a5c22200cc0d8e6020eca7f410264b',
        i686: '26fa5709ae5558b5513d7b0044b12a73e2ab023d7df570276c5e7a75b630afef',
      x86_64: 'fc6ecb1acb475d6dbe7c75028b3c251218e5a75dc5431b5e5e549f56bc5b5cde',
  })

  depends_on 'libxfixes'
  depends_on 'libx11'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
