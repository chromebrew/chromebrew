require 'package'

class Vulkan_headers < Package
  description 'Vulkan header files'
  homepage 'https://github.com/KhronosGroup/Vulkan-Headers'
  @_ver = '1.2.171'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/KhronosGroup/Vulkan-Headers/archive/v#{@_ver}.tar.gz"
  source_sha256 'b86266544ab1d6780c5ee6cdf10f24ba9ec4c97bc83d2229e0fb8142c36e52ac'

  binary_url({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_headers-1.2.171-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_headers-1.2.171-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_headers-1.2.171-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_headers-1.2.171-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'f0795e78f27c10ab4180743b4f1f46b566007da4fd348b4cdf6e35ee4c3fb72b',
     armv7l: 'f0795e78f27c10ab4180743b4f1f46b566007da4fd348b4cdf6e35ee4c3fb72b',
       i686: '285dbac0bfd1e95262b2d60a0b9ff3dc5c300b794777871552d104a4e7f68549',
     x86_64: 'f054e13240784b5c989d0a046a36dcffed794b1d6cbd3ff3998c2d70d32b0234'
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
