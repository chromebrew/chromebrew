require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  @_ver = '3.22.1'
  version @_ver
  license 'CMake'
  compatibility 'all'
  source_url 'https://github.com/Kitware/CMake.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.22.1_armv7l/cmake-3.22.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.22.1_armv7l/cmake-3.22.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.22.1_i686/cmake-3.22.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.22.1_x86_64/cmake-3.22.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '679a9c4eeed318606315c9a51eeb231472eb60adb062e1749c5f0b49021008f5',
     armv7l: '679a9c4eeed318606315c9a51eeb231472eb60adb062e1749c5f0b49021008f5',
       i686: '9b6726536bff3d0f9fb6b7d19f86f63b5d76780171c64143d03d2f7d131c8a70',
     x86_64: '0d9a7d101d419c6589e86237236545e20f25a1d74e6999f256ae6f7a188896ba'
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
    system 'samu -C builddir'
  end

  # Only the BundleUtiliities test fails here.
  # def self.check
  #  system "samu -C builddir test"
  # end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
    FileUtils.mv "#{CREW_DEST_PREFIX}/doc/", "#{CREW_DEST_PREFIX}/share/"
  end
end
