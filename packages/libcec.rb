require 'buildsystems/cmake'

class Libcec < CMake
  description 'Pulse-Eights libcec for the Pulse-Eight USB-CEC adapter'
  homepage 'https://libcec.pulse-eight.com/'
  version '8.1.1'
  license 'GPL'
  compatibility 'aarch64 armv7l x86_64' # Not kernel compatible w/ i686 kernel.
  source_url 'https://github.com/Pulse-Eight/libcec.git'
  git_hashtag "libcec-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e1f984cbb9f909e3687384f90cb43c2d2edecc2464c2aefd0ef073ee0dcb1253',
     armv7l: 'e1f984cbb9f909e3687384f90cb43c2d2edecc2464c2aefd0ef073ee0dcb1253',
     x86_64: '3f0eec65449d3bb686ae9325d49aa0426f98bdc9c75047b373dd22c3de579d9f'
  })

  depends_on 'eudev' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libx11' => :library
  depends_on 'libxrandr' => :library
  depends_on 'ncurses' => :executable
  depends_on 'p8_platform' => :library
  depends_on 'python3' => :library
  depends_on 'swig' => :build

  def self.patch
    system "sed -i 's,<curses.h>,<ncurses/curses.h>,' src/cec-client/curses/CursesControl.cpp"
  end

  cmake_options "-DCMAKE_INSTALL_LIBDIR=#{CREW_LIB_PREFIX} -DBUILD_SHARED_LIBS=ON -DHAVE_LINUX_API=ON"
end
