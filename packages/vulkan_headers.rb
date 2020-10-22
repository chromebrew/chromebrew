# Adapted from Arch Linux vulkan-headers PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/vulkan-headers/trunk/PKGBUILD

require 'package'

class Vulkan_headers < Package
  description 'Vulkan header files'
  version '1.2.157'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers/archive/v1.2.157.tar.gz'
  source_sha256 'dbc121f58641acd45c386ee96ecd5e10a124c489087443d7367fff4b53b49283'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_headers-1.2.157-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_headers-1.2.157-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_headers-1.2.157-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/vulkan_headers-1.2.157-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'b130e7ad0d764c3e829d0da62260ebdbe192deb699a1540eb9a347b2c1948429',
     armv7l: 'b130e7ad0d764c3e829d0da62260ebdbe192deb699a1540eb9a347b2c1948429',
       i686: '75afde70082d150fbf190381da67e6d179968c8d0ecd59151b57a2fade44e8dc',
     x86_64: '6bc64672860d7c8dc181d730b892ade24003e28b86102be78df28a6025d390b6',
  })

  depends_on 'cmake'
  depends_on 'git'
  depends_on 'cmake' => ':build'
  depends_on 'git' => ':build'

	def self.build
		system 'mkdir build'
		Dir.chdir ("build") do
		system "cmake -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} \
			-DCMAKE_INSTALL_LIBDIR=#{CREW_LIB_PREFIX} \
			-DCMAKE_BUILD_TYPE=Release \
			.. && make"
		end
	end
	
	def self.install
	Dir.chdir ("build") do
		system 'make',
			"DESTDIR=#{CREW_DEST_DIR}",
			'install'
		end
	end
end
