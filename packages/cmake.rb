require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  @_ver = '3.20.5'
  version @_ver
  license 'CMake'
  compatibility 'all'
  source_url "https://github.com/Kitware/CMake/releases/download/v#{@_ver}/cmake-#{@_ver}.tar.gz"
  source_sha256 '12c8040ef5c6f1bc5b8868cede16bb7926c18980f59779e299ab52cbc6f15bb0'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.20.5_armv7l/cmake-3.20.5-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.20.5_armv7l/cmake-3.20.5-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.20.5_i686/cmake-3.20.5-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.20.5_x86_64/cmake-3.20.5-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '75be8bfa3cc657338fad5f6787064f6bf15db3920a9745d855fd96d4ae27267f',
     armv7l: '75be8bfa3cc657338fad5f6787064f6bf15db3920a9745d855fd96d4ae27267f',
       i686: '6857b4eb68676dcd828438ea141bc2152416c5819296aa7e177061787f6530fc',
     x86_64: 'c09c700554d7d10689c81fece6a31d9a8c0ded0dc040e78ca2ff5501f4304a80'
  })

  depends_on 'llvm' => :build

  def self.patch
    if Dir.exist? "#{CREW_PREFIX}/include/ncursesw"
      system "sed -i \"51s,$,\\n  set(CURSES_INCLUDE_PATH #{CREW_PREFIX}/include/ncursesw),\" Modules/FindCurses.cmake"
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
