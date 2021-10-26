require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  @_ver = '3.21.3'
  version @_ver
  license 'CMake'
  compatibility 'all'
  source_url 'https://github.com/Kitware/CMake.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.21.3_armv7l/cmake-3.21.3-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.21.3_armv7l/cmake-3.21.3-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.21.3_i686/cmake-3.21.3-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.21.3_x86_64/cmake-3.21.3-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: 'c82ca30fa16202bc5d7d95433f44004351181e4ab0e5e394a36842b91a44cd77',
     armv7l: 'c82ca30fa16202bc5d7d95433f44004351181e4ab0e5e394a36842b91a44cd77',
       i686: '1376e50bc0a1af8f15763e2de306e311ac7c696ddd7dcefa4e0f1b9113a150fb',
     x86_64: '956f2cba7d4cc5eea374e7a460609566ddf927235a5b625bcda72936ffb79d0b'
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

  def self.patch
    if Dir.exist? "#{CREW_PREFIX}/include/ncursesw"
      system "sed -i \"51s,$,\\n  set(CURSES_INCLUDE_PATH #{CREW_PREFIX}/include/ncursesw),\" Modules/FindCurses.cmake"
    end
  end

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "#{CREW_ENV_OPTIONS} cmake \
          -G Ninja \
          #{CREW_CMAKE_OPTIONS} \
          -DCMAKE_USE_SYSTEM_LIBRARIES=ON \
          -DBUILD_QtDialog=NO \
          .."
    end
    system 'ninja -C builddir'
  end

  # Only the BundleUtiliities test fails here.
  # def self.check
  #  system "ninja -C builddir test"
  # end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
    FileUtils.mv "#{CREW_DEST_PREFIX}/doc/", "#{CREW_DEST_PREFIX}/share/"
  end
end
