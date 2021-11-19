require 'package'

class Vulkan_headers < Package
  description 'Vulkan header files'
  homepage 'https://github.com/KhronosGroup/Vulkan-Headers'
  @_ver = '1.2.199'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.2.199_armv7l/vulkan_headers-1.2.199-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.2.199_armv7l/vulkan_headers-1.2.199-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.2.199_i686/vulkan_headers-1.2.199-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.2.199_x86_64/vulkan_headers-1.2.199-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'f7a4b78aeae4227cb91d47aa289c4c93c21423f964f287f141e21e9f5191ec3e',
     armv7l: 'f7a4b78aeae4227cb91d47aa289c4c93c21423f964f287f141e21e9f5191ec3e',
       i686: 'dccc499f2966cd547432d408b92d02ab961b327ea7f5ecae858ad41a5df72136',
     x86_64: 'ff3a92ddab7b522bc25d36fb179bc78884c3053e946e0f32e4cafcb2589cbe4f'
  })

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
