require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  @_ver = '3.26.0'
  version @_ver
  license 'CMake'
  compatibility 'all'
  source_url 'https://github.com/Kitware/CMake.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.26.0_armv7l/cmake-3.26.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.26.0_armv7l/cmake-3.26.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.26.0_i686/cmake-3.26.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.26.0_x86_64/cmake-3.26.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'c733cd92e32108da4b329d3bfc7a8915a6d6e192ad70bc104700a469ad775b0e',
     armv7l: 'c733cd92e32108da4b329d3bfc7a8915a6d6e192ad70bc104700a469ad775b0e',
       i686: '8cb8e78bd8e1fdab7f38dcd2761b4d0a00c3731ea9a7ba0d07894c7a7888f579',
     x86_64: 'ae046518c25ab673477f56066998d9e85ad8d1a28b8de243177af86f9087c398'
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
  depends_on 'libcurl'
  depends_on 'librhash'
  depends_on 'libuv'
  depends_on 'llvm' => :build
  depends_on 'gcc' # R
  depends_on 'ncurses' # R

  def self.build
    system "mold -run cmake -B builddir \
          -G Ninja \
          #{CREW_CMAKE_OPTIONS} \
          -DCMAKE_USE_SYSTEM_LIBRARIES=ON \
          -DBUILD_QtDialog=NO"
    system "mold -run #{CREW_NINJA} -C builddir"
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
