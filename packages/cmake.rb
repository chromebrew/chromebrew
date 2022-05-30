require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  @_ver = '3.23.2'
  version @_ver
  license 'CMake'
  compatibility 'all'
  source_url 'https://github.com/Kitware/CMake.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.23.2_armv7l/cmake-3.23.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.23.2_armv7l/cmake-3.23.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.23.2_i686/cmake-3.23.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.23.2_x86_64/cmake-3.23.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '2dfe03152d856f05fd80bf4f8916c251acb97373644b9879866c67d297e53d12',
     armv7l: '2dfe03152d856f05fd80bf4f8916c251acb97373644b9879866c67d297e53d12',
       i686: 'ea70f7b463171f41ecca6d754c1bd865977ef509666b49b78c3f1de99bf4314d',
     x86_64: '4e7e2eaf6e0f60dd1d9149181da5cd09b6c8d0cd66e89c24534004064099ffaa'
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
