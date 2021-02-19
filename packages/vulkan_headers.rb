require 'package'

class Vulkan_headers < Package
  description 'Vulkan header files'
  homepage 'https://github.com/KhronosGroup/Vulkan-Headers'
  @_ver = '1.2.170'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/KhronosGroup/Vulkan-Headers/archive/v#{@_ver}.tar.gz"
  source_sha256 '6fa84897197bd72cf4b1a686c903df67fc0fe108e4ed02e6adb3d72c468f1c1f'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_headers-1.2.170-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_headers-1.2.170-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_headers-1.2.170-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_headers-1.2.170-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'c91cdf5912c17199838f36df1cfb8f1c225a747f177ef81383c0fbef330974d4',
     armv7l: 'c91cdf5912c17199838f36df1cfb8f1c225a747f177ef81383c0fbef330974d4',
       i686: '325276ef0c915d261c9745b587667e7f316379fc697fd7747ecf63733e39584a',
     x86_64: '7d53e53b6ec7afc74e8b4d5dea6b57a6b2debdd6d4be72a72e48601272c4caa8'
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
