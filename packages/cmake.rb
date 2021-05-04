require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  @_ver = '3.20.1'
  version @_ver
  license 'CMake'
  compatibility 'all'
  source_url "https://github.com/Kitware/CMake/releases/download/v#{@_ver}/cmake-#{@_ver}.tar.gz"
  source_sha256 '3f1808b9b00281df06c91dd7a021d7f52f724101000da7985a401678dfe035b0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.20.1_armv7l/cmake-3.20.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.20.1_armv7l/cmake-3.20.1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.20.1_i686/cmake-3.20.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.20.1_x86_64/cmake-3.20.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: '078af3199ebab9ea478b9c162098b1746a91a83a62052017991e6d66ff5e81e2',
     armv7l: '078af3199ebab9ea478b9c162098b1746a91a83a62052017991e6d66ff5e81e2',
       i686: '715e5a2d8b097df0f753cac11e6c15fc3b5a47765de4f9be554715c65bbb7a5b',
     x86_64: '61e754f415704a3feaeb6a0f0bdbd7cbdd958f76f779b32be49c799e351a0852'
  })

  depends_on 'llvm' => :build

  def self.patch
    if Dir.exist? "#{CREW_PREFIX}/include/ncursesw"
      system 'sed -i "51s,$,\n  set(CURSES_INCLUDE_PATH ' + "#{CREW_PREFIX}/include/ncursesw" + ')," Modules/FindCurses.cmake'
    end
  end

  def self.build
    system "env #{CREW_ENV_OPTIONS} \
      ./bootstrap --prefix=#{CREW_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.mv "#{CREW_DEST_PREFIX}/doc/", "#{CREW_DEST_PREFIX}/share/"
  end
end
