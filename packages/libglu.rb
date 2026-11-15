require 'package'

class Libglu < Package
  description 'Mesa OpenGL Utility library'
  homepage 'https://www.mesa3d.org/'
  version '9.0.3'
  license 'SGI-B-2.0'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/mesa/glu.git'
  git_hashtag "glu-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f4610c827c80fe817f0f91eaf52a0bc820d1051747af117a849ed6749dea2e3f',
     armv7l: 'f4610c827c80fe817f0f91eaf52a0bc820d1051747af117a849ed6749dea2e3f',
       i686: 'c96fdcd776b3686caca43aaf17506b33269043666b1c21b00036b425d41486a2',
     x86_64: '878ab6a7129c6fcfaa576343ee2c00eeb68daed891a9ae9dcc4a961a084c825f'
  })

  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libglvnd' => :library

  def self.build
    system 'meson setup build'
    system "meson configure #{CREW_MESON_OPTIONS} \
              build"
    system 'ninja -C build'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C build install"
    # Get these from xorg_server package
    @deletefiles = %W[#{CREW_DEST_PREFIX}/bin/X #{CREW_DEST_MAN_PREFIX}/man1/Xserver.1]
    @deletefiles.each do |f|
      FileUtils.rm_f f
    end
  end
end
