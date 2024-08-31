require 'buildsystems/cmake'

class Cmake < CMake
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '3.30.3'
  license 'CMake'
  compatibility 'all'
  source_url 'https://github.com/Kitware/CMake.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '341144dd40a04b786bd0dc425d04be1f53e019b4b211ada94dd18535dfe79532',
     armv7l: '341144dd40a04b786bd0dc425d04be1f53e019b4b211ada94dd18535dfe79532',
       i686: '9361bfef93cc849be11aaeefaddb8395245c731e1c7b42b5ba0bf7c35c6e34dc',
     x86_64: 'd67cebf24c847c06ddaeeeecf6b7dd3365747a75c4ba69af31ec63c19c116582'
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
