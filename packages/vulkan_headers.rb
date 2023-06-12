require 'package'

class Vulkan_headers < Package
  description 'Vulkan header files'
  homepage 'https://github.com/KhronosGroup/Vulkan-Headers'
  @_ver = '1.3.252'
  version @_ver
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.3.252_armv7l/vulkan_headers-1.3.252-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.3.252_armv7l/vulkan_headers-1.3.252-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.3.252_x86_64/vulkan_headers-1.3.252-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'ea657e39cff29f1cbf1f5fa87f698676a0ff6d3b561078f77441600e38b07864',
     armv7l: 'ea657e39cff29f1cbf1f5fa87f698676a0ff6d3b561078f77441600e38b07864',
     x86_64: '080abb53d4cdabffb242bdc212d35836829954db2330f2b2110cf9e8ad2f2536'
  })

  def self.build
    system "cmake -B builddir \
        -G Ninja \
        #{CREW_CMAKE_OPTIONS}"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
