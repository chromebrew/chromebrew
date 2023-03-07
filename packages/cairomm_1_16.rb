require 'package'

class Cairomm_1_16 < Package
  description 'The Cairomm package provides a C++ interface to Cairo.'
  homepage 'https://www.cairographics.org/'
  @_ver = '1.16.2'
  version @_ver
  license 'LGPL-2+'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/cairo/cairomm.git'
  git_hashtag version

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairomm_1_16/1.16.2_armv7l/cairomm_1_16-1.16.2-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairomm_1_16/1.16.2_armv7l/cairomm_1_16-1.16.2-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairomm_1_16/1.16.2_i686/cairomm_1_16-1.16.2-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cairomm_1_16/1.16.2_x86_64/cairomm_1_16-1.16.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'f762614a3a14af45a249fb9c218864f90fc5f17c76e162b1ebac72a3f50ff8d6',
     armv7l: 'f762614a3a14af45a249fb9c218864f90fc5f17c76e162b1ebac72a3f50ff8d6',
       i686: '69c11234edaa48db3e9f916a66566eea806f451c48d787174a015c9d905607d3',
     x86_64: '98b889a6b0e94f60e931471faead51a176f1efd88bf17221c04ac1a13b2f195e'
  })

  depends_on 'cairo' # R
  depends_on 'gcc' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libsigcplusplus3' # R
  depends_on 'libxrender' => :build
  depends_on 'libxxf86vm' => :build

  def self.build
    system "meson setup #{CREW_MESON_OPTIONS} \
    -Dbuild-documentation=false \
    -Dbuild-examples=false \
    -Dbuild-tests=false \
    builddir"
    system 'meson configure builddir'
    system "#{CREW_NINJA} -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} #{CREW_NINJA} -C builddir install"
  end
end
