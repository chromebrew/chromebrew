# Adapted from Arch Linux vulkan-headers PKGBUILD at:
# https://github.com/archlinux/svntogit-packages/raw/packages/vulkan-headers/trunk/PKGBUILD

require 'package'

class Vulkan_headers < Package
  description 'Vulkan header files'
  version '1.2.157'
  compatibility 'all'
  source_url 'https://github.com/KhronosGroup/Vulkan-Headers/archive/v1.2.157.tar.gz'
  source_sha256 'dbc121f58641acd45c386ee96ecd5e10a124c489087443d7367fff4b53b49283'

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
