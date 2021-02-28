require 'package'

class Swi_prolog < Package
  description 'SWI-Prolog offers a comprehensive free Prolog environment. Since its start in 1987, SWI-Prolog development has been driven by the needs of real world applications. SWI-Prolog is widely used in research and education as well as commercial applications. Join over a million users who have downloaded SWI-Prolog.'
  homepage 'https://www.swi-prolog.org/'
  @_ver = '8.2.4'
  version "#{@_ver}-1"
  compatibility 'i686,x86_64'
  source_url "https://www.swi-prolog.org/download/stable/src/swipl-#{@_ver}.tar.gz"
  source_sha256 'f4bcc78437f9080ab089762e9e6afa7071df7f584c14999b92b9a90a4efbd7d8'

  binary_url({
    i686: 'https://dl.bintray.com/chromebrew/chromebrew/swi_prolog-8.2.4-1-chromeos-i686.tar.xz',
  x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/swi_prolog-8.2.4-1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    i686: 'b0a31e97f541b9dd7d7c2c873941afafefba5193438a7dc4e9e8689f5c3b7205',
  x86_64: '0f235b7fa550e879d3ff54d73e15b071edeeb7c6af9a4ff7a55bf2768e5b7ee4'
  })

  case ARCH
  when 'i686', 'x86_64'
    depends_on 'libyaml'
    depends_on 'libarchive'
    depends_on 'libdb'
  end

  def self.build
    FileUtils.rm_rf 'builddir'
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "LC_ALL=en_US.utf8 cmake -G Ninja \
      #{CREW_CMAKE_OPTIONS} \
      -DCURSES_CURSES_LIBRARY=#{CREW_LIB_PREFIX}/libncurses.so.6 \
      -DCURSES_INCLUDE_PATH=#{CREW_PREFIX}/include/ncurses  \
      -DCMAKE_C_FLAGS=-flto=auto \
      -DCMAKE_CXX_FLAGS=-flto=auto \
      -DCMAKE_EXE_LINKER_FLAGS=-flto=auto \
      -DINSTALL_TESTS=ON \
      -DUSE_TCMALLOC=OFF \
      -DSWIPL_PACKAGES_JAVA=OFF \
      -DSWIPL_PACKAGES_X=OFF \
      -DSWIPL_PACKAGES_QT=OFF \
      .."
      system 'LC_ALL=en_US.utf8 ../scripts/pgo-compile.sh'
      system 'LC_ALL=en_US.utf8 ninja'
    end
  end

  def self.check
    Dir.chdir 'builddir' do
      system 'LC_ALL=en_US.utf8 ctest -j 2'
    end
  end

  def self.install
    system "LC_ALL=en_US.utf8 DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
