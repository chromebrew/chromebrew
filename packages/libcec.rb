# Adapted from Arch Linux libcec PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/libcec/trunk/PKGBUILD

require 'package'

class Libcec < Package
  description 'Pulse-Eights libcec for the Pulse-Eight USB-CEC adapter'
  homepage 'http://libcec.pulse-eight.com/'
  version '6.0.2'
  license 'GPL'
  compatibility 'aarch64 armv7l x86_64' # Not kernel compatible w/ i686 kernel.
  source_url 'https://github.com/Pulse-Eight/libcec/archive/libcec-6.0.2.tar.gz'
  source_sha256 '090696d7a4fb772d7acebbb06f91ab92e025531c7c91824046b9e4e71ecb3377'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcec/6.0.2_armv7l/libcec-6.0.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcec/6.0.2_armv7l/libcec-6.0.2-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libcec/6.0.2_x86_64/libcec-6.0.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '7151a17a85563aeec9a5a9eb936db42281f84f2a9cc7bd1b9a9d9c5f18729b81',
     armv7l: '7151a17a85563aeec9a5a9eb936db42281f84f2a9cc7bd1b9a9d9c5f18729b81',
     x86_64: 'f931339f4bcc45d68c61ea07a3f51040a803cce535f70498159b7c60fc856dd2'
  })

  depends_on 'eudev' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxrandr' # R
  depends_on 'p8_platform' # R
  depends_on 'python3' # R
  depends_on 'swig' => :build
  depends_on 'ncurses' # R

  def self.patch
    system "sed -i 's,<curses.h>,<ncurses/curses.h>,' src/cec-client/curses/CursesControl.cpp"
  end

  def self.build
    FileUtils.mkdir_p 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        -DCMAKE_INSTALL_LIBDIR=#{CREW_LIB_PREFIX} \
        -DCMAKE_INSTALL_LIBDIR_NOARCH=#{CREW_LIB_PREFIX} \
        -DBUILD_SHARED_LIBS=1 \
        -DHAVE_LINUX_API=1 \
        -Wno-dev \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
