require 'package'

class Swi_prolog < Package
  description 'SWI-Prolog offers a comprehensive free Prolog environment. Since its start in 1987, SWI-Prolog development has been driven by the needs of real world applications. SWI-Prolog is widely used in research and education as well as commercial applications. Join over a million users who have downloaded SWI-Prolog.'
  homepage 'https://www.swi-prolog.org/'
  version '8.2.4'
  license 'BSD-2'
  compatibility 'i686,x86_64'
  source_url "https://www.swi-prolog.org/download/stable/src/swipl-#{version}.tar.gz"
  source_sha256 'f4bcc78437f9080ab089762e9e6afa7071df7f584c14999b92b9a90a4efbd7d8'
  binary_compression 'tar.xz'

  binary_url({
    i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/swi_prolog/8.2.4_i686/swi_prolog-8.2.4-chromeos-i686.tar.xz',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/swi_prolog/8.2.4_x86_64/swi_prolog-8.2.4-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    i686: 'd8985a0a160baca9d6565d4177a43a840450ef4bb96eefae476a51ce27fec063',
    x86_64: 'cbb431b0bd28fa1c581071aeb1eeda79b70b4ec3c28c2d07b509054e810cb62b'
  })

  depends_on 'libyaml'
  depends_on 'libarchive'
  depends_on 'libdb'
  depends_on 'jdk8'

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G Ninja \
      #{CREW_CMAKE_OPTIONS} \
      -DCURSES_CURSES_LIBRARY=#{CREW_LIB_PREFIX}/libncurses.so.6 \
      -DCURSES_INCLUDE_PATH=#{CREW_PREFIX}/include/ncurses  \
      -DCMAKE_C_FLAGS=-flto=auto \
      -DCMAKE_CXX_FLAGS=-flto=auto \
      -DCMAKE_EXE_LINKER_FLAGS=-flto=auto \
      -DINSTALL_TESTS=ON \
      .."
      system '../scripts/pgo-compile.sh'
      system 'ninja'
    end
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
