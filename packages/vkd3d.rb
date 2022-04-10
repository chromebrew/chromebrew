require 'package'

class Vkd3d < Package
  description 'Vkd3d is a 3D graphics library built on top of Vulkan. It has an API very similar, but not identical, to Direct3D 12.'
  homepage 'https://wiki.winehq.org/Vkd3d/'
  version '1.3'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://dl.winehq.org/vkd3d/source/vkd3d-1.3.tar.xz'
  source_sha256 '134b347806d34a4d2b39ea29ff1c2b38443793803a3adc50800855bb929fb8b2'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vkd3d/1.3_armv7l/vkd3d-1.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vkd3d/1.3_armv7l/vkd3d-1.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vkd3d/1.3_i686/vkd3d-1.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vkd3d/1.3_x86_64/vkd3d-1.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '90afb4961e1e781d04d373ccb90ddb86684dc2d70996078014283974cb95bdb0',
     armv7l: '90afb4961e1e781d04d373ccb90ddb86684dc2d70996078014283974cb95bdb0',
       i686: '0f504ecc0fa598f2eabc3eb77ae4f55f4e0482019e5d0f9fcffad6a3a7eed889',
     x86_64: 'a14fe1fc952c60a888c624825d82211f53d305d64f9905ae86d3b52673c2c307'
  })

  depends_on 'libxcb'
  depends_on 'spirv_headers' => :build
  depends_on 'spirv_tools'
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader'

  def self.build
    system "#{CREW_ENV_FNO_LTO_OPTIONS} ./configure #{CREW_OPTIONS} \
            --with-xcb \
            --with-spirv-tools"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
