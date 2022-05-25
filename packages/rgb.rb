require 'package'

class Rgb < Package
  description 'X color name database'
  homepage 'https://xorg.freedesktop.org/'
  version '1.0.6-1'
  license 'custom'
  compatibility 'all'
  source_url 'https://www.x.org/releases/individual/app/rgb-1.0.6.tar.bz2'
  source_sha256 'bbca7c6aa59939b9f6a0fb9fff15dfd62176420ffd4ae30c8d92a6a125fbe6b0'
  binary_compression 'tar.xz'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rgb/1.0.6-1_armv7l/rgb-1.0.6-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rgb/1.0.6-1_armv7l/rgb-1.0.6-1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rgb/1.0.6-1_i686/rgb-1.0.6-1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/rgb/1.0.6-1_x86_64/rgb-1.0.6-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '27166ea52928b8accc832ec1487f7a93cd25db22920a990d81c612a4b32ebc96',
     armv7l: '27166ea52928b8accc832ec1487f7a93cd25db22920a990d81c612a4b32ebc96',
       i686: '4af3c2ad090fc4a3bb80e574338452b26d6893e2f2185ce8bdc6f6ce73b2824d',
     x86_64: '5921f6f8cf98c4a7ff6760921a4a3b3092bb875caf3baea4b5f4e515d837edcc'
  })

  depends_on 'xorg_proto' => :build

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
