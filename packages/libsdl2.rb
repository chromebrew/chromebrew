require 'package'

class Libsdl2 < Package
  description 'Simple DirectMedia Layer is a cross-platform development library designed to provide low level access to audio, keyboard, mouse, joystick, and graphics hardware via OpenGL and Direct3D.'
  homepage 'http://www.libsdl.org'
  version '2.28.0'
  license 'ZLIB'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/libsdl-org/SDL.git'
  git_hashtag "release-#{version}"
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsdl2/2.28.0_armv7l/libsdl2-2.28.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsdl2/2.28.0_armv7l/libsdl2-2.28.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsdl2/2.28.0_x86_64/libsdl2-2.28.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'fd584f04ee0c5fdc49aaaa13454a618aa56ed71f73b17123edac21720191fa2a',
     armv7l: 'fd584f04ee0c5fdc49aaaa13454a618aa56ed71f73b17123edac21720191fa2a',
     x86_64: '707350fb01f4f26e87873388adedda472357ec2453bf6dcfb48a3e37fce29c61'
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
