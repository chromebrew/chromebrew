require 'package'

class Libsdl2 < Package
  description 'Simple DirectMedia Layer is a cross-platform development library designed to provide low level access to audio, keyboard, mouse, joystick, and graphics hardware via OpenGL and Direct3D.'
  homepage 'http://www.libsdl.org'
  version '2.26.4'
  license 'ZLIB'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/libsdl-org/SDL.git'
  git_hashtag "release-#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsdl2/2.26.4_armv7l/libsdl2-2.26.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsdl2/2.26.4_armv7l/libsdl2-2.26.4-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsdl2/2.26.4_x86_64/libsdl2-2.26.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '49aba0d4b30c1c16f49f65b1af95311f1c005dec1ef38cc161bf6144a2487ab5',
     armv7l: '49aba0d4b30c1c16f49f65b1af95311f1c005dec1ef38cc161bf6144a2487ab5',
     x86_64: '50526afc74ed9d5a60e2d3669dfda4347fd8a0ddca6ab16d2709a3aae3abe148'
  })

  depends_on 'alsa_lib' => :build
  depends_on 'glibc' # R
  depends_on 'ibus' => :build
  depends_on 'libdecor' # R
  depends_on 'nasm' => :build
  depends_on 'pulseaudio' => :build
  depends_on 'xwayland' => :build

  def self.build
    @arch_options = ARCH == 'x86_64' ? '-DOPT_DEF_SSEMATH=ON' : ''
    system "cmake -B builddir -G Ninja \
      #{CREW_CMAKE_OPTIONS} \
      #{@arch_options} \
      -Wno-dev"
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
