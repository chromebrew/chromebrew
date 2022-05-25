require 'package'

class Libglu < Package
  description 'Mesa OpenGL Utility library'
  homepage 'https://www.mesa3d.org/'
  version '9.0.2'
  license 'SGI-B-2.0'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/mesa/glu.git'
  git_hashtag "glu-#{version}"
  binary_compression 'tar.zst'

  binary_url({
      i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libglu/9.0.2_i686/libglu-9.0.2-chromeos-i686.tar.zst',
   aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libglu/9.0.2_armv7l/libglu-9.0.2-chromeos-armv7l.tar.zst',
    armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libglu/9.0.2_armv7l/libglu-9.0.2-chromeos-armv7l.tar.zst',
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libglu/9.0.2_x86_64/libglu-9.0.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
      i686: '1019df9d060a8deffe29d83c5f7bc3ae36aad7ce5aa0922ef992630cb5a54b9c',
   aarch64: 'ac1d9cc34fd08c5fcff392ba91b28e58e99bf86b9d1575be073404516d297898',
    armv7l: 'ac1d9cc34fd08c5fcff392ba91b28e58e99bf86b9d1575be073404516d297898',
    x86_64: '55358e0044362fd6a9a4c1abf11f6d5757cd8cc757d96787da850e3b107ef4d1'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'mesa' # R
  depends_on 'libglvnd' # R

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
