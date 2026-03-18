require 'buildsystems/cmake'

class Cmake < CMake
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '4.3.0'
  license 'CMake'
  compatibility 'all'
  source_url 'https://gitlab.kitware.com/cmake/cmake.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cedc8dffc0955196685fe49ddabad93cdd0a4fcfec72f5f2067e2a0cdb52ce77',
     armv7l: 'cedc8dffc0955196685fe49ddabad93cdd0a4fcfec72f5f2067e2a0cdb52ce77',
       i686: 'a059eb1a8d2003fd3029bc39664e704a393c84aa0e3b23c4321fcf79483721f1',
     x86_64: '95b3ecfc796a9f47cf1ee21686a9ed08069928bde9a5ee1ca5e7f3ef3c7de1dc'
  })

  depends_on 'bzip2' => :build
  depends_on 'cppdap' => :executable_only
  depends_on 'curl' => :executable_only
  depends_on 'expat' => :executable_only
  depends_on 'gcc_lib' => :executable_only
  depends_on 'glibc' => :executable_only
  depends_on 'jsoncpp' => :executable_only
  depends_on 'libarchive' => :executable_only
  depends_on 'libnghttp2' => :build
  depends_on 'librhash' => :executable_only
  depends_on 'libuv' => :executable_only
  depends_on 'llvm_lib' => :build
  depends_on 'ncurses' => :executable_only
  depends_on 'xzutils' => :build
  depends_on 'zlib' => :executable_only
  depends_on 'zstd' => :build

  def self.prebuild
    @current_installed_cmake_major_version = `cmake --version | head -n 1 | awk '{print \$3}'`.chomp.split('.').reverse[1..2].reverse.join('.')
    @new_cmake_major_version = version.split('.').reverse[1..2].reverse.join('.')
    # Only do tests on major version changes.
    @cmake_testing = @current_installed_cmake_major_version != @new_cmake_major_version
    puts 'Build testing will be skipped since this is not a major version change from the existing cmake.'.orange unless @cmake_testing
  end

  cmake_options "-DCMake_BUILD_LTO=ON \
     -DCMAKE_USE_SYSTEM_LIBRARIES=ON \
     -DCMAKE_USE_SYSTEM_LIBARCHIVE=ON \
     -DBUILD_TESTING=#{@cmake_testing ? 'YES' : 'NO'} \
     -DBUILD_QtDialog=NO"

  # Failed tests:
  # BundleUtilities (armv7l,x86_64)
  # BootstrapTest (armv7l,i686,x86_64)
  # CMakeLib.testDebuggerNamedPipe-Project (armv7l,i686,x86_64)
  # CMakeLib.testDebuggerNamedPipe-Script (armv7l,i686,x86_64)
  # RunCMake.CMakeRelease (armv7l,i686,x86_64)
  def self.check
    return unless @cmake_testing

    system "#{CREW_NINJA} -C builddir test || true"
  end

  cmake_install_extras do
    FileUtils.mv "#{CREW_DEST_PREFIX}/doc/", "#{CREW_DEST_PREFIX}/share/"
  end
end
