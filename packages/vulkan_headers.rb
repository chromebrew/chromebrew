require 'package'

class Vulkan_headers < Package
  description 'Vulkan header files'
  homepage 'https://github.com/KhronosGroup/Vulkan-Headers'
  @_ver = '1.2.189'
  version @_ver
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://github.com/KhronosGroup/Vulkan-Headers/archive/v#{@_ver}.tar.gz"
  source_sha256 '0939d6cb950746f6f9cab59399c0a99628ed186426a972996599f90d34d8a99a'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.2.189_armv7l/vulkan_headers-1.2.189-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.2.189_armv7l/vulkan_headers-1.2.189-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.2.189_i686/vulkan_headers-1.2.189-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.2.189_x86_64/vulkan_headers-1.2.189-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '1a219ac7c4cd4f323a63cb39d9aa0141d351be8f333875c201140f2d56f2cfa8',
     armv7l: '1a219ac7c4cd4f323a63cb39d9aa0141d351be8f333875c201140f2d56f2cfa8',
       i686: '9c19facd083446993359bac2f5e57ba315cc60c9c5083cd04e01558bc6abff12',
     x86_64: 'd678eaf1a9f33a28da7c6ad373bc3a0baa2210b058373ab49fd55dd0a9fc6df6'
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
