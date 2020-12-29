require 'package'

class Vulkan_headers < Package
  description 'Vulkan header files'
  homepage 'https://github.com/KhronosGroup/Vulkan-Headers'
  version '1.2.165'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers/archive/v1.2.165.tar.gz'
  source_sha256 '3f9435a93ba13d94d0c3265a47e0436579e46bb9ca085e9b16a753458e4d79d2'

  binary_url ({
     aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_headers-1.2.165-chromeos-armv7l.tar.xz',
      armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_headers-1.2.165-chromeos-armv7l.tar.xz',
        i686: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_headers-1.2.165-chromeos-i686.tar.xz',
      x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_headers-1.2.165-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     aarch64: '03d07ab7485d23e1c0018f2ec02c877997382db4abf3ae80a43cda6a494c5383',
      armv7l: '03d07ab7485d23e1c0018f2ec02c877997382db4abf3ae80a43cda6a494c5383',
        i686: '66ec66419c0725af304b422462364449785c92c2599f392044b31d39d4d4ce4b',
      x86_64: 'f4a32c518e378b6ec9c6d7535df7b7269a04ee0bdff98c50435219fbf6610788',
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
