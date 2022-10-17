require 'package'

class Vulkan_headers < Package
  description 'Vulkan header files'
  homepage 'https://github.com/KhronosGroup/Vulkan-Headers'
  @_ver = '1.3.231'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.3.231_armv7l/vulkan_headers-1.3.231-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.3.231_armv7l/vulkan_headers-1.3.231-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.3.231_i686/vulkan_headers-1.3.231-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.3.231_x86_64/vulkan_headers-1.3.231-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b19c5a426f01cf251c5660abccae19f6ab5082bdd12c7b6470856579664e0897',
     armv7l: 'b19c5a426f01cf251c5660abccae19f6ab5082bdd12c7b6470856579664e0897',
       i686: '12f2ae15bff517cbefbbe61e59b408431235f60b78d6adef55740d5eb3ca83b2',
     x86_64: 'b627b23a35c7f934e7eed6227091dd897e8c4554102cc387fbf75379dd3de1d5'
  })

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
