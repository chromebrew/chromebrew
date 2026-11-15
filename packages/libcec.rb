require 'buildsystems/cmake'

class Libcec < CMake
  description 'Pulse-Eights libcec for the Pulse-Eight USB-CEC adapter'
  homepage 'https://libcec.pulse-eight.com/'
  version '8.1.7'
  license 'GPL'
  compatibility 'aarch64 armv7l x86_64' # Not kernel compatible w/ i686 kernel.
  source_url 'https://github.com/Pulse-Eight/libcec.git'
  git_hashtag "libcec-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd8c6969edf7d44cdf9f40a18c6916c7354cb5cbc06830283ec78e6c1fc261ff0',
     armv7l: 'd8c6969edf7d44cdf9f40a18c6916c7354cb5cbc06830283ec78e6c1fc261ff0',
     x86_64: '64c3b8bc22c3a39a4a201ff98245fb6bfdc52a543335655ede4c22232540b27d'
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
