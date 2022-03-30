require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  @_ver = '3.23.0'
  version @_ver
  license 'CMake'
  compatibility 'all'
  source_url 'https://github.com/Kitware/CMake.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.23.0_armv7l/cmake-3.23.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.23.0_armv7l/cmake-3.23.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.23.0_i686/cmake-3.23.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.23.0_x86_64/cmake-3.23.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1e31576926ad32bb574f57d06d26eaf1f49fe578802b8ba672aeaa731ed3dd9e',
     armv7l: '1e31576926ad32bb574f57d06d26eaf1f49fe578802b8ba672aeaa731ed3dd9e',
       i686: '0cdbc190fd23f9c35007ae83ebe4c3105aca907b646116ed5383eeb947c48945',
     x86_64: 'fb97af30472cb4b23944b9c5d1247282edebc2a4debaaef25caf3ddc6cae58e7'
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
      # mold linker breaks the build on i686, so just disable for this
      # build
      system "cmake \
          -G Ninja \
          #{CREW_CMAKE_OPTIONS.gsub('mold', 'gold')} \
          -DCMAKE_USE_SYSTEM_LIBRARIES=ON \
          -DBUILD_QtDialog=NO \
          .."
    end
    system 'ninja -C builddir'
  end

  # Failed tests:
  # BundleUtilities
  # GeneratorExpression
  # RunCMake.CMakeRelease
  # RunCMake.file-GET_RUNTIME_DEPENDENCIES
  # def self.check
  #   system 'ninja -C builddir test || true'
  # end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    FileUtils.mv "#{CREW_DEST_PREFIX}/doc/", "#{CREW_DEST_PREFIX}/share/"
  end
end
