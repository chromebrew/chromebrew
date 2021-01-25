require 'package'

class Vulkan_headers < Package
  description 'Vulkan header files'
  homepage 'https://github.com/KhronosGroup/Vulkan-Headers'
  @_ver = '1.2.168'
  version @_ver
  compatibility 'all'
  source_url "https://github.com/KhronosGroup/Vulkan-Headers/archive/v#{@_ver}.tar.gz"
  source_sha256 'ec6a69836a8cd413f89071a9b978d0547849192538550c706a8e560089d59cb2'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_headers-1.2.168-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_headers-1.2.168-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_headers-1.2.168-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_headers-1.2.168-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '288faae9c1b306bdc0cc1d5f2828557daeb2b19d5eb195b0b413933612aad4a9',
      armv7l: '288faae9c1b306bdc0cc1d5f2828557daeb2b19d5eb195b0b413933612aad4a9',
        i686: '9c0b47c0c75ba355ead9e62164ba2506fd49f8bae172430d0b9c8caf44077b08',
      x86_64: '9036ea7177c6d7f3529e936820c50df0f813cc454a68af0c33215f3ddd6f71da',
  })

  def self.build
    Dir.mkdir 'build'
    Dir.chdir 'build' do
    system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} \
      -DCMAKE_INSTALL_LIBDIR=#{CREW_LIB_PREFIX} \
      -DCMAKE_BUILD_TYPE=Release \
      .. && make"
    end
  end

  def self.install
    Dir.chdir 'build' do
      system 'make',
        "DESTDIR=#{CREW_DEST_DIR}",
        'install'
    end
  end
end
