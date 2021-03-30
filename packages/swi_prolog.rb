require 'package'

class Swi_prolog < Package
  description 'SWI-Prolog offers a comprehensive free Prolog environment. Since its start in 1987, SWI-Prolog development has been driven by the needs of real world applications. SWI-Prolog is widely used in research and education as well as commercial applications. Join over a million users who have downloaded SWI-Prolog.'
  homepage 'https://www.swi-prolog.org/'
  @_ver = '8.2.4-1'
  version @_ver
  license 'BSD-2'
  compatibility 'i686,x86_64'
  source_url "https://www.swi-prolog.org/download/stable/src/swipl-#{@_ver}.tar.gz"
  source_sha256 'f4bcc78437f9080ab089762e9e6afa7071df7f584c14999b92b9a90a4efbd7d8'

  case ARCH
  when 'i686', 'x86_64'
    depends_on 'libyaml'
    depends_on 'libarchive'
    depends_on 'libdb'
    depends_on 'jdk8'
  end

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G Ninja \
      #{CREW_CMAKE_OPTIONS} \
      -DCURSES_CURSES_LIBRARY=#{CREW_LIB_PREFIX}/libncursesw.so.6 \
      -DCURSES_INCLUDE_PATH=#{CREW_PREFIX}/include/ncursesw  \
      -DCMAKE_C_FLAGS=-flto=auto \
      -DCMAKE_CXX_FLAGS=-flto=auto \
      -DCMAKE_EXE_LINKER_FLAGS=-flto=auto \
      -DINSTALL_TESTS=ON \
      .."
      system '../scripts/pgo-compile.sh'
    end
    system 'ninja -C builddir'
  end

  # def self.check
  # Dir.chdir 'builddir' do
  # system 'ctest -j 2'
  # end
  # end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
