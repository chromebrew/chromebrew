require 'buildsystems/cmake'

class Cmake < CMake
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '4.2.3'
  license 'CMake'
  compatibility 'all'
  source_url 'https://gitlab.kitware.com/cmake/cmake.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '624b7711a73cbaf08a377a7903b83913f12851e417d05991b814d9950cb4d4a7',
     armv7l: '624b7711a73cbaf08a377a7903b83913f12851e417d05991b814d9950cb4d4a7',
       i686: 'a20786ba13c357fac35a74f72a1b334b81934c93c175989f718ac16d6a16612b',
     x86_64: 'c3e0a875b106cc9e3250dbbc3f13080aa3ca639214da30a75ce0df65f13644c2'
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
  depends_on 'llvm_lib' => :build
  depends_on 'ncurses' # R
  depends_on 'xzutils' => :build
  depends_on 'zlib' # R
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
