require 'package'

class Vulkan_headers < Package
  description 'Vulkan header files'
  homepage 'https://github.com/KhronosGroup/Vulkan-Headers'
  @_ver = '1.2.200'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://github.com/KhronosGroup/Vulkan-Headers/archive/v#{@_ver}.tar.gz"
  source_sha256 '0939d6cb950746f6f9cab59399c0a99628ed186426a972996599f90d34d8a99a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.2.200_armv7l/vulkan_headers-1.2.200-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.2.200_armv7l/vulkan_headers-1.2.200-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.2.200_i686/vulkan_headers-1.2.200-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.2.200_x86_64/vulkan_headers-1.2.200-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '5a5667d6e87c10b44ce1f8b753ab1b262c3f9080f54ce7813bb0073e8b84bcd1',
     armv7l: '5a5667d6e87c10b44ce1f8b753ab1b262c3f9080f54ce7813bb0073e8b84bcd1',
       i686: 'c2013362fec23d3c98168f15eb333819e7dc4e2d5727514231a6698765c99e4f',
     x86_64: 'a08323b44455380865c5d034bba4f9ebaffa4731612ec9c15f1ed2241b9de402'
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
