require 'buildsystems/cmake'

class Libcec < CMake
  description 'Pulse-Eights libcec for the Pulse-Eight USB-CEC adapter'
  homepage 'https://libcec.pulse-eight.com/'
  version '8.1.6'
  license 'GPL'
  compatibility 'aarch64 armv7l x86_64' # Not kernel compatible w/ i686 kernel.
  source_url 'https://github.com/Pulse-Eight/libcec.git'
  git_hashtag "libcec-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8cea5027c367df51d1b057a7ba4da809c8c75a67c451ef5681a271295553b4d8',
     armv7l: '8cea5027c367df51d1b057a7ba4da809c8c75a67c451ef5681a271295553b4d8',
     x86_64: '0bf4b4ed9f64f8c391f92a81dad893d446bd7777d45c9fce8bb92962659467ff'
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
