require 'package'

class Vulkan_headers < Package
  description 'Vulkan header files'
  homepage 'https://github.com/KhronosGroup/Vulkan-Headers'
  @_ver = '1.2.184'
  version @_ver
  license 'Apache-2.0'
  compatibility 'x86_64 aarch64 armv7l'
  source_url "https://github.com/KhronosGroup/Vulkan-Headers/archive/v#{@_ver}.tar.gz"
  source_sha256 'de1889ff550c1a78e752fbdf71117ac319fb674b0abe080a4e6e9053da2aea85'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.2.184_armv7l/vulkan_headers-1.2.184-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.2.184_armv7l/vulkan_headers-1.2.184-chromeos-armv7l.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/vulkan_headers/1.2.184_x86_64/vulkan_headers-1.2.184-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'b17aa592829e1ff8810c92f2cf28bf0b77f198bf0d5d71c5fcc45c12206dc2f8',
     armv7l: 'b17aa592829e1ff8810c92f2cf28bf0b77f198bf0d5d71c5fcc45c12206dc2f8',
     x86_64: '276679a7d8b8061198fe4262e89eca1f745208ea23e26dea99e2510d668795b0'
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
