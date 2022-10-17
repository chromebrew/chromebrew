require 'package'

class Vulkan_headers < Package
  description 'Vulkan header files'
  homepage 'https://github.com/KhronosGroup/Vulkan-Headers'
  @_ver = '1.3.230'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.3.230_armv7l/vulkan_headers-1.3.230-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.3.230_armv7l/vulkan_headers-1.3.230-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.3.230_i686/vulkan_headers-1.3.230-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.3.230_x86_64/vulkan_headers-1.3.230-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd36b9887edca21f8092ed048bdce3b097312e1074c34a801088ac8eeadb9981b',
     armv7l: 'd36b9887edca21f8092ed048bdce3b097312e1074c34a801088ac8eeadb9981b',
       i686: 'de184f007aad9a8b937c769e9cbd37a4257e7d7bde3e39eaa947f0b7ee1d5369',
     x86_64: 'db133f28b049375d584831c05020bb25778a7728d12d5f27198ee3d3f1c56d87'
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
    system 'mold -run samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
