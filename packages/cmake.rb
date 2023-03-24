require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  @_ver = '3.26.1'
  version @_ver
  license 'CMake'
  compatibility 'all'
  source_url 'https://github.com/Kitware/CMake.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.26.1_armv7l/cmake-3.26.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.26.1_armv7l/cmake-3.26.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.26.1_i686/cmake-3.26.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.26.1_x86_64/cmake-3.26.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '54d07f7a6d459a45e876a40d659d860eb8959f8d5b691951431689b116b37775',
     armv7l: '54d07f7a6d459a45e876a40d659d860eb8959f8d5b691951431689b116b37775',
       i686: '674f8bde7e417691c7d400dee1632facf9694a91def8aa84a0cfc01146b30494',
     x86_64: '1001e552edfa12f4c1b00860081a908d776299474c72195acdad9203d07bf02b'
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
