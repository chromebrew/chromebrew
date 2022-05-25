require 'package'

class Vkd3d < Package
  description 'Vkd3d is a 3D graphics library built on top of Vulkan. It has an API very similar, but not identical, to Direct3D 12.'
  homepage 'https://wiki.winehq.org/Vkd3d/'
  version '1.6'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://dl.winehq.org/vkd3d/source/vkd3d-1.6.tar.xz'
  source_sha256 '9dce98c32c48932370bd51f50e2f9316e7bdacaf69506ce5a1bf28a590926c87'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vkd3d/1.6_armv7l/vkd3d-1.6-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vkd3d/1.6_armv7l/vkd3d-1.6-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vkd3d/1.6_i686/vkd3d-1.6-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vkd3d/1.6_x86_64/vkd3d-1.6-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '022d7e9e7e15a2546b462f46b2c79b477b46581204b80ea81ef8e1317b145320',
     armv7l: '022d7e9e7e15a2546b462f46b2c79b477b46581204b80ea81ef8e1317b145320',
       i686: '4d6896053db854565178eaa05d58dac00f14872bdf7bb7ff66eb9836320cf1e2',
     x86_64: '6ea8560991499d40a425e4f5a64a4c61fdd26c68256eb6d30c168211519f84ef'
  })

  depends_on 'glibc' # R
  depends_on 'libxcb' => :build
  depends_on 'ncurses' # R
  depends_on 'spirv_headers' => :build
  depends_on 'spirv_tools' # R
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build
  no_lto

  def self.build
    system "./configure #{CREW_OPTIONS} \
            --with-xcb \
            --with-spirv-tools"
    system 'make'
  end

  def self.check
    # Tests don't work in a container due to 'Failed to create Vulkan instance' errors.
    system 'make check || true'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
