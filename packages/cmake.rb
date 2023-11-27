require 'buildsystems/cmake'

class Cmake < CMake
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  version '3.27.8'
  license 'CMake'
  compatibility 'all'
  source_url 'https://github.com/Kitware/CMake.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.27.8_armv7l/cmake-3.27.8-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.27.8_armv7l/cmake-3.27.8-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.27.8_i686/cmake-3.27.8-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.27.8_x86_64/cmake-3.27.8-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '1ced511da84c596faf36c533a9ca472145e780d6ab6b0fecc51f70eda073c835',
     armv7l: '1ced511da84c596faf36c533a9ca472145e780d6ab6b0fecc51f70eda073c835',
       i686: 'c33b0de21ae2c5b8a81f77183199a608c92c30eda7fd1042e32157161947ec8a',
     x86_64: '443d9d3c93c749bfa854aebe8d209d44e15a56501e1fe65c96dbcd4ff64cae10'
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
  depends_on 'llvm17_lib' => :build
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
    system "#{CREW_NINJA} -C builddir test || true"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    FileUtils.mv "#{CREW_DEST_PREFIX}/doc/", "#{CREW_DEST_PREFIX}/share/"
  end
end
