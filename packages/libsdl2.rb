require 'package'

class Libsdl2 < Package
  description 'Simple DirectMedia Layer is a cross-platform development library designed to provide low level access to audio, keyboard, mouse, joystick, and graphics hardware via OpenGL and Direct3D.'
  homepage 'http://www.libsdl.org'
  @_ver = '2.26.0'
  version @_ver
  license 'ZLIB'
  compatibility 'all'
  source_url 'https://github.com/libsdl-org/SDL.git'
  git_hashtag "release-#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsdl2/2.26.0_armv7l/libsdl2-2.26.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsdl2/2.26.0_armv7l/libsdl2-2.26.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsdl2/2.26.0_i686/libsdl2-2.26.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libsdl2/2.26.0_x86_64/libsdl2-2.26.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'a6033a31126a264f29cd8e75b65d2e330d3db08899093c37d8bb0f8132b23c38',
     armv7l: 'a6033a31126a264f29cd8e75b65d2e330d3db08899093c37d8bb0f8132b23c38',
       i686: '0d51f4cddfe464896e55301e2f11d98b0141faa51c9e33d4eaa25693785bef07',
     x86_64: '26cf152d4202263e98325b7ed171a46d02ea39d1c02cc93d43cd4b818ee9ee88'
  })

  depends_on 'xwayland' => :build
  depends_on 'glibc' # R
  depends_on 'alsa_lib' => :build
  depends_on 'ibus' => :build
  depends_on 'pulseaudio' => :build
  depends_on 'nasm' => :build

  def self.build
    @arch_options = ARCH == 'x86_64' ? '-DOPT_DEF_SSEMATH=ON' : ''
    FileUtils.mkdir_p 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        #{@arch_options} \
        -Wno-dev \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
