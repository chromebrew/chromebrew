require 'package'

class Vkd3d < Package
  description 'Vkd3d is a 3D graphics library built on top of Vulkan. It has an API very similar, but not identical, to Direct3D 12.'
  homepage 'https://wiki.winehq.org/Vkd3d/'
  version '1.2'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://dl.winehq.org/vkd3d/source/vkd3d-1.2.tar.xz'
  source_sha256 'b04b030fcbf0f2dacc933c76c74b449bffef1fc1a18d50254ef1ad3e380df96b'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vkd3d/1.2_armv7l/vkd3d-1.2-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vkd3d/1.2_armv7l/vkd3d-1.2-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vkd3d/1.2_i686/vkd3d-1.2-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vkd3d/1.2_x86_64/vkd3d-1.2-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5590a1dee31aa583ead90f499fcb032256d9d299b796a063341b74d2d26fdade',
     armv7l: '5590a1dee31aa583ead90f499fcb032256d9d299b796a063341b74d2d26fdade',
       i686: 'a8844704bb96e0b1f0ee6775b9a3574a71d1dfc318913ca4771f9d17edd4f9a0',
     x86_64: 'f52bb2d5c5a93dae17bae05e34b9e83815891ce5ea7f1dfb934294ab7a32074e'
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
