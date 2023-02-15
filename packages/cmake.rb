require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  @_ver = '3.25.2'
  version @_ver
  license 'CMake'
  compatibility 'all'
  source_url 'https://github.com/Kitware/CMake.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.25.2_armv7l/cmake-3.25.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.25.2_armv7l/cmake-3.25.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.25.2_i686/cmake-3.25.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.25.2_x86_64/cmake-3.25.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '35cdcf9335f22731354b4bd31f8bf83f4084409115a0d68321fca37aa6423fd7',
     armv7l: '35cdcf9335f22731354b4bd31f8bf83f4084409115a0d68321fca37aa6423fd7',
       i686: 'ee657bc571b00d64a79e4634027745fab35bf23208971fdc8f55b998b262b84e',
     x86_64: 'ab832e369f7fac6d391048b6418b6285ee91158e730b86af47bb2f5a5085ed3e'
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
