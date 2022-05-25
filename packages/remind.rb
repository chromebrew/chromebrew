require 'package'

class Remind < Package
  description 'Remind is a sophisticated calendar and alarm program.'
  homepage 'https://www.roaringpenguin.com/products/remind'
  version '03.01.15'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://www.roaringpenguin.com/files/download/remind-03.01.15.tar.gz'
  source_sha256 '8adab4c0b30a556c34223094c5c74779164d5f3b8be66b8039f44b577e678ec1'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/remind/03.01.15_armv7l/remind-03.01.15-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/remind/03.01.15_armv7l/remind-03.01.15-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/remind/03.01.15_i686/remind-03.01.15-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/remind/03.01.15_x86_64/remind-03.01.15-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '65bae63d254189573223d8771b257e8a0186ee6bfcfb8c97a7df74995e4fe042',
     armv7l: '65bae63d254189573223d8771b257e8a0186ee6bfcfb8c97a7df74995e4fe042',
       i686: '833cf2d86df2ed62af3056d7633a7c133bd289a459d10ad39e7160575dc2ad25',
     x86_64: '93144719846bf23d63c0b31c688ce5815b74e6600fe034d9c783cdd6887c7b0f'
  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
