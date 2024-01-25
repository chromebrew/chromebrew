require 'package'

class Libiec61883 < Package
  description 'A higher level API for streaming DV, MPEG-2 and audio over Linux IEEE 1394'
  homepage 'https://www.kernel.org/pub/linux/libs/ieee1394/'
  version '1.2.0'
  license 'LGPL-2.1 or GPL-2'
  compatibility 'all'
  source_url 'https://www.kernel.org/pub/linux/libs/ieee1394/libiec61883-1.2.0.tar.xz'
  source_sha256 'd1e02c7e276fac37313a2f8c1c33d7a9e19282ff16f32e72435428ff5121f09e'
  binary_compression 'tar.xz'

  binary_sha256({
    aarch64: 'dac204a81221d75bf4ef10ffd80da9dd1a2c7622f22c3d581585e6676ca15837',
     armv7l: 'dac204a81221d75bf4ef10ffd80da9dd1a2c7622f22c3d581585e6676ca15837',
       i686: '00e12728736b325440c2c32a64efb84c919d5494d213a6bd936e02047cb9f3d6',
     x86_64: '5a056cfdf4e7b45a7e5a842897fc70daa3b78f9e66d09e8b8ec016bf647d3cd0'
  })

  depends_on 'libraw1394'

  def self.build
    system 'filefix'
    system "env CFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto -I#{CREW_PREFIX}/include/harfbuzz' \
      CXXFLAGS='-pipe -fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      LDFLAGS='-fno-stack-protector -U_FORTIFY_SOURCE -flto=auto' \
      ./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make DESTDIR=#{CREW_DEST_DIR} install"
  end
end
