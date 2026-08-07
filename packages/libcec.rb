require 'buildsystems/cmake'

class Libcec < CMake
  description 'Pulse-Eights libcec for the Pulse-Eight USB-CEC adapter'
  homepage 'https://libcec.pulse-eight.com/'
  version '8.1.4'
  license 'GPL'
  compatibility 'aarch64 armv7l x86_64' # Not kernel compatible w/ i686 kernel.
  source_url 'https://github.com/Pulse-Eight/libcec.git'
  git_hashtag "libcec-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ea1498057369c37ba9a27bfad574f248d1059d29053b7211d4749a0b282bfac0',
     armv7l: 'ea1498057369c37ba9a27bfad574f248d1059d29053b7211d4749a0b282bfac0',
     x86_64: '66aa998fc7f45341ce1e67314837f629a1a96f25a4e59518a0679c69276c6203'
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
