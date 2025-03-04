require 'buildsystems/cmake'

class Cmake < CMake
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '3.31.6'
  license 'CMake'
  compatibility 'all'
  source_url 'https://github.com/Kitware/CMake.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '606716f4c369ec3f3d7e7ff7965bc5795b5f9f6cc4d042bc3f0c1901ba8db12a',
     armv7l: '606716f4c369ec3f3d7e7ff7965bc5795b5f9f6cc4d042bc3f0c1901ba8db12a',
       i686: '91a1e5924c32a09821676e83dfe9d22d553d87e1a12cca3d5be25c9d55ffad7b',
     x86_64: '5715086459b5e79b20eab5c6a16dae9c5cf706c5825b3f16c4fe8c10c49752e1'
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
  depends_on 'llvm19_lib' => :build
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

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    FileUtils.mv "#{CREW_DEST_PREFIX}/doc/", "#{CREW_DEST_PREFIX}/share/"
  end
end
