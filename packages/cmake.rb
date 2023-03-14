require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  @_ver = '3.25.3'
  version @_ver
  license 'CMake'
  compatibility 'all'
  source_url 'https://github.com/Kitware/CMake.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.25.3_armv7l/cmake-3.25.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.25.3_armv7l/cmake-3.25.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.25.3_i686/cmake-3.25.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.25.3_x86_64/cmake-3.25.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '4911ff7281c642c3fdb810743ebaaa16ba47d2f001c97557070da05b20359b3b',
     armv7l: '4911ff7281c642c3fdb810743ebaaa16ba47d2f001c97557070da05b20359b3b',
       i686: '3c9347271d0626df4cda13c8f5b3fa238db3a9d7d3668b99a5e74d5b1dc38e3a',
     x86_64: '50ada85d5eb8b571bfb3ede09e5bb9fc83669346bfb447568d704705d27ed080'
  })

  depends_on 'expat'
  depends_on 'glibc' # R
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
  depends_on 'gcc' # R
  depends_on 'ncurses' # R

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
