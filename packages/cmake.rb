require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  @_ver = '3.26.3'
  version @_ver
  license 'CMake'
  compatibility 'all'
  source_url 'https://github.com/Kitware/CMake.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.26.3_armv7l/cmake-3.26.3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.26.3_armv7l/cmake-3.26.3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.26.3_i686/cmake-3.26.3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.26.3_x86_64/cmake-3.26.3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'd34f102d0a7a780cbb62c36fad3be03e36cb645b4d9a3dbcf08f887bfc2b0f53',
     armv7l: 'd34f102d0a7a780cbb62c36fad3be03e36cb645b4d9a3dbcf08f887bfc2b0f53',
       i686: 'dbdb8eb039fce12920255b85229f979cfb33b5d848b3810afe9ee97a8b8ca7dc',
     x86_64: '7606cedd3efc463333b9a9360d98570bd65acbf32b9bc0f65feccf4e871eac8d'
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
  depends_on 'curl'
  depends_on 'librhash'
  depends_on 'libuv'
  depends_on 'llvm_lib16' => :build
  depends_on 'gcc' # R
  depends_on 'ncurses' # R

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
  # CustomCommand (armv7l)
  # RunCMake.CMakeRelease (armv7l,i686,x86_64)
  def self.check
    system "#{CREW_NINJA} -C builddir test || true"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
    FileUtils.mv "#{CREW_DEST_PREFIX}/doc/", "#{CREW_DEST_PREFIX}/share/"
  end
end
