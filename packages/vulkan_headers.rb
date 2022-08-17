require 'package'

class Vulkan_headers < Package
  description 'Vulkan header files'
  homepage 'https://github.com/KhronosGroup/Vulkan-Headers'
  @_ver = '1.3.224'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.2.200_i686/vulkan_headers-1.2.200-chromeos-i686.tpxz',
 aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.3.224_armv7l/vulkan_headers-1.3.224-chromeos-armv7l.tar.zst',
  armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.3.224_armv7l/vulkan_headers-1.3.224-chromeos-armv7l.tar.zst',
  x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.3.224_x86_64/vulkan_headers-1.3.224-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    i686: 'c2013362fec23d3c98168f15eb333819e7dc4e2d5727514231a6698765c99e4f',
 aarch64: '07d06412605ad77da5eb584ff0004ca8bd375facdec7f208cc8507d87574770a',
  armv7l: '07d06412605ad77da5eb584ff0004ca8bd375facdec7f208cc8507d87574770a',
  x86_64: '20e3b90d93447e620d730bfe3f0f55d97cfd19134ed275b5672f5d962863118a'
  })

  git_hashtag "v#{@_ver}"

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
