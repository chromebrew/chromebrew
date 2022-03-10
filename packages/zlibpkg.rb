require 'package'

class Zlibpkg < Package
  description 'zlib is a massively spiffy yet delicately unobtrusive compression library.'
  homepage 'https://www.zlib.net/'
  # When upgrading zlibpkg, be sure to upgrade minizip in tandem.
  @_ver = '1.2.11'
  version "#{@_ver}-7"
  license 'zlib'
  compatibility 'all'
  source_url "https://www.zlib.net/zlib-#{@_ver}.tar.gz"
  source_sha256 'c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.2.11-7_armv7l/zlibpkg-1.2.11-7-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.2.11-7_armv7l/zlibpkg-1.2.11-7-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.2.11-7_i686/zlibpkg-1.2.11-7-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/zlibpkg/1.2.11-7_x86_64/zlibpkg-1.2.11-7-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '929afe8f670183e7719d06bb1fc83fc115bd74c7c41f1ac7bb86450c8c5d3c7f',
     armv7l: '929afe8f670183e7719d06bb1fc83fc115bd74c7c41f1ac7bb86450c8c5d3c7f',
       i686: 'a55c4ddd77260fb7c043d23e9dbfd822cec2cdb8c71e7690856e5305c5b3ba52',
     x86_64: '887c6ffde269a62eb3c7b995f8488bdb2795faa8777b00ec76fca7258862fe25'
  })

  def self.patch
    system "sed -i 's,CMAKE_INSTALL_PREFIX}/lib,CMAKE_INSTALL_PREFIX}/#{ARCH_LIB},g' CMakeLists.txt"
    system "sed -i 's,CMAKE_INSTALL_PREFIX}/share/pkgconfig,CMAKE_INSTALL_PREFIX}/#{ARCH_LIB}/pkgconfig,g' CMakeLists.txt"
  end

  def self.build
    # Build zlib proper
    FileUtils.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G Ninja #{CREW_CMAKE_OPTIONS} .."
    end
    system 'samu -C builddir'
  end

  def self.install
    # Install zlib
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
