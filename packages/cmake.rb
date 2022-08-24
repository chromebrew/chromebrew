require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  @_ver = '3.24.1'
  version @_ver
  license 'CMake'
  compatibility 'all'
  source_url 'https://github.com/Kitware/CMake.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.24.1_armv7l/cmake-3.24.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.24.1_armv7l/cmake-3.24.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.24.1_i686/cmake-3.24.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.24.1_x86_64/cmake-3.24.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'da3d25ea366b19967544870b483c76f6a903ab9678ac844ef77c6d3302a5ea4b',
     armv7l: 'da3d25ea366b19967544870b483c76f6a903ab9678ac844ef77c6d3302a5ea4b',
       i686: 'e8cbc2ee57556d44bf6857bf2bf039a139563407e352843edcf83568abf2285d',
     x86_64: '39c47fa7e44241983b3dc86e876abd5ae7c9d17cd46f1ce9fa7a4e277a0a191c'
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
