require 'buildsystems/cmake'

class Libcec < CMake
  description 'Pulse-Eights libcec for the Pulse-Eight USB-CEC adapter'
  homepage 'https://libcec.pulse-eight.com/'
  version '7.1.1'
  license 'GPL'
  compatibility 'aarch64 armv7l x86_64' # Not kernel compatible w/ i686 kernel.
  source_url 'https://github.com/Pulse-Eight/libcec.git'
  git_hashtag "libcec-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fb7bbb3614a5d7daf9d8529a27a84bed7124c97ee3ea3e07baf6b65de5209bd6',
     armv7l: 'fb7bbb3614a5d7daf9d8529a27a84bed7124c97ee3ea3e07baf6b65de5209bd6',
     x86_64: 'd2177b97fe644d706224ce58891186d52902080a8b5f266a9f85c884c8e448c8'
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
