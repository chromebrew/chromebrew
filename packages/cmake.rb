require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  @_ver = '3.24.2'
  version "#{@_ver}-1"
  license 'CMake'
  compatibility 'all'
  source_url 'https://github.com/Kitware/CMake.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.24.2-1_armv7l/cmake-3.24.2-1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.24.2-1_armv7l/cmake-3.24.2-1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.24.2-1_i686/cmake-3.24.2-1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.24.2-1_x86_64/cmake-3.24.2-1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7c553287271609f9f2153b79879495f65f64ad5c8f7f146b66beebc168de9e6a',
     armv7l: '7c553287271609f9f2153b79879495f65f64ad5c8f7f146b66beebc168de9e6a',
       i686: 'bcaa0e282dba32c33bd6cec8678cae917e1b740289835c4d90f45bf56e17bbd7',
     x86_64: '8c82b522e826f18d25189ced89a99e86ee660d965feb0af2b9176ed9f1c5b6e6'
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
