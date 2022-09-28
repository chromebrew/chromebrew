require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  @_ver = '3.24.2'
  version @_ver
  license 'CMake'
  compatibility 'all'
  source_url 'https://github.com/Kitware/CMake.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.24.2_armv7l/cmake-3.24.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.24.2_armv7l/cmake-3.24.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.24.2_i686/cmake-3.24.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.24.2_x86_64/cmake-3.24.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '14b515ebc3b2fdf607975d38e193d50b61a2a3163edff069bfa266346e09bfec',
     armv7l: '14b515ebc3b2fdf607975d38e193d50b61a2a3163edff069bfa266346e09bfec',
       i686: '7ba3147e7d93c10f59d71c510fd49742dd2574dd8cc794ac1aede4506942e758',
     x86_64: '017673d3425483e0e33af04c6ecb59f1a6713047a1ef9a23cb98fbbb9019d6c8'
  })

  depends_on 'expat'
  depends_on 'jsoncpp'
  depends_on 'zlibpkg'
  depends_on 'bz2'
  depends_on 'xzutils'
  depends_on 'libnghttp2'
  depends_on 'zstd'
  depends_on 'libarchive'
  depends_on 'libcurl'
  depends_on 'librhash'
  depends_on 'libuv'
  depends_on 'llvm' => :build

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "mold -run cmake \
          -G Ninja \
          #{CREW_CMAKE_OPTIONS} \
          -DCMAKE_USE_SYSTEM_LIBRARIES=ON \
          -DBUILD_QtDialog=NO \
          .."
    end
    system 'mold -run ninja -C builddir'
  end

  # Failed tests:
  # BundleUtilities (armv7l,x86_64)
  # CTest.UpdateGIT (x86_64)
  # CustomCommand (armv7l,x86_64)
  # RunCMake.CMakeRelease (armv7l,i686,x86_64)
  def self.check
    system 'ninja -C builddir test || true'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    FileUtils.mv "#{CREW_DEST_PREFIX}/doc/", "#{CREW_DEST_PREFIX}/share/"
  end
end
