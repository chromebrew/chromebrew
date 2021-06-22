require 'package'

class Cmake < Package
  description 'CMake is an open-source, cross-platform family of tools designed to build, test and package software.'
  homepage 'https://cmake.org/'
  @_ver = '3.20.4'
  version @_ver
  license 'CMake'
  compatibility 'all'
  source_url "https://github.com/Kitware/CMake/releases/download/v#{@_ver}/cmake-#{@_ver}.tar.gz"
  source_sha256 '87a4060298f2c6bb09d479de1400bc78195a5b55a65622a7dceeb3d1090a1b16'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.20.4_armv7l/cmake-3.20.4-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.20.4_armv7l/cmake-3.20.4-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.20.4_i686/cmake-3.20.4-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmake/3.20.4_x86_64/cmake-3.20.4-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '77018414bfe96cdffc8e7240c1b73cc39759679e0ff239b49ba5a5443f785332',
     armv7l: '77018414bfe96cdffc8e7240c1b73cc39759679e0ff239b49ba5a5443f785332',
       i686: 'b0fe910f5b1866a5405587735a971940d7625b359f48d19b530a77c3a5b4c92a',
     x86_64: '468c6364a9972a7261149784db9357b72a2adf66bb07db0adf4af154f9f12f65'
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
