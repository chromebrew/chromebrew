require 'package'
require 'fileutils'

class Swi_prolog < Package
  description 'SWI-Prolog offers a comprehensive free Prolog environment. Since its start in 1987, SWI-Prolog development has been driven by the needs of real world applications. SWI-Prolog is widely used in research and education as well as commercial applications. Join over a million users who have downloaded SWI-Prolog.'
  homepage 'https://www.swi-prolog.org/'
  version '8.2.4'
  compatibility 'all'
  source_url 'https://www.swi-prolog.org/download/stable/src/swipl-8.2.4.tar.gz'
  source_sha256 'f4bcc78437f9080ab089762e9e6afa7071df7f584c14999b92b9a90a4efbd7d8'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libyaml'
  depends_on 'libarchive'
  depends_on 'libdb'

  def self.build
    FileUtils.remove_dir 'build', true
    Dir.mkdir 'build'
    Dir.chdir 'build' do
        system "cmake -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DCURSES_CURSES_LIBRARY=#{CREW_LIB_PREFIX}/libncurses.so.6 \
        -DCURSES_INCLUDE_PATH=#{CREW_PREFIX}/include/ncurses  \
        -DCMAKE_C_FLAGS=-flto=auto \
        -DCMAKE_CXX_FLAGS=-flto=auto \
        -DINSTALL_TESTS=ON \
        .."
        system "../scripts/pgo-compile.sh"
        system "ninja"
    end
  end

  def self.check
    Dir.chdir 'build' do
        system "ctest -j 2"
    end
  end

  def self.install
    Dir.chdir('build') do
        system "DESTDIR=#{CREW_DEST_DIR} ninja install"
    end
  end
end
