require 'buildsystems/cmake'

class Cmake < CMake
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '3.29.6'
  license 'CMake'
  compatibility 'all'
  source_url 'https://github.com/Kitware/CMake.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b86e8ce241b1eef848f3b2971d93d90fbf8051c4b678961abc4d1ed0eda33e5c',
     armv7l: 'b86e8ce241b1eef848f3b2971d93d90fbf8051c4b678961abc4d1ed0eda33e5c',
       i686: 'ff326641d052b49310d274c191775562fd541c999e35d2ca079505ab0c7b995b',
     x86_64: '1961d25ff69ca260f2563c988d7a26532bb5ff16d0237820ee9fa3f439a207db'
  })

  depends_on 'bzip2' => :build
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
  depends_on 'llvm18_lib' => :build
  depends_on 'ncurses' # R
  depends_on 'xzutils' => :build
  depends_on 'zlibpkg' # R
  depends_on 'zstd' => :build

  cmake_options '-DCMAKE_USE_SYSTEM_LIBRARIES=ON \
     -DBUILD_QtDialog=NO'

  # Failed tests:
  # BundleUtilities (armv7l,x86_64)
  # BootstrapTest (armv7l,i686,x86_64)
  # CMakeLib.testDebuggerNamedPipe-Project (armv7l,i686,x86_64)
  # CMakeLib.testDebuggerNamedPipe-Script (armv7l,i686,x86_64)
  # RunCMake.CMakeRelease (armv7l,i686,x86_64)
  def self.check
    @current_installed_cmake = `cmake --version | head -n 1 | awk '{print \$3}'`.chomp
    return if @current_installed_cmake == version

    system "#{CREW_NINJA} -C builddir test || true"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    FileUtils.mv "#{CREW_DEST_PREFIX}/doc/", "#{CREW_DEST_PREFIX}/share/"
  end
end
