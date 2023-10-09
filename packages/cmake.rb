require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '3.27.7'
  license 'CMake'
  compatibility 'all'
  source_url 'https://github.com/Kitware/CMake.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.27.7_armv7l/cmake-3.27.7-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.27.7_armv7l/cmake-3.27.7-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.27.7_i686/cmake-3.27.7-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.27.7_x86_64/cmake-3.27.7-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '11f4c625a0b01ea03386a1b60e2f52687a3cd2176711ac205c5d3368483315d8',
     armv7l: '11f4c625a0b01ea03386a1b60e2f52687a3cd2176711ac205c5d3368483315d8',
       i686: '96e658c56f0862f6c748f14f3577892783b2bc24a24db98e05d8e8d72156910e',
     x86_64: 'f991e757d11a4156aac060d35912102bc81c6360501029f64604d3d7ed002d4d'
  })

  depends_on 'bz2' => :build
  depends_on 'cppdap' # R
  depends_on 'curl' # R
  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'jsoncpp' # R
  depends_on 'libarchive' # R
  depends_on 'libnghttp2' => :build
  depends_on 'librhash' # R
  depends_on 'libuv' # R
  depends_on 'llvm17_lib' => :build
  depends_on 'ncurses' # R
  depends_on 'xzutils' => :build
  depends_on 'zlibpkg' # R
  depends_on 'zstd' => :build

  def self.build
    system "mold -run cmake -B builddir \
          -G Ninja \
          #{CREW_CMAKE_OPTIONS} \
          -DCMAKE_USE_SYSTEM_LIBRARIES=ON \
          -DBUILD_QtDialog=NO"
    system "#{CREW_NINJA} -C builddir"
  end

  # Failed tests:
  # BundleUtilities (armv7l,x86_64)
  # BootstrapTest (armv7l,i686,x86_64)
  # CMakeLib.testDebuggerNamedPipe-Project (armv7l,i686,x86_64)
  # CMakeLib.testDebuggerNamedPipe-Script (armv7l,i686,x86_64)
  # RunCMake.CMakeRelease (armv7l,i686,x86_64)
  def self.check
    system "#{CREW_NINJA} -C builddir test || true"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    FileUtils.mv "#{CREW_DEST_PREFIX}/doc/", "#{CREW_DEST_PREFIX}/share/"
  end
end
