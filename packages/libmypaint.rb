require 'package'

class Libmypaint < Package
  description 'Libmypaint is MyPaint\'s brushstroke rendering code, in a form that can be used by other programs.'
  homepage 'http://mypaint.org/'
  @_ver = '1.6.1'
  version @_ver
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/mypaint/libmypaint.git'
  git_hashtag "v#{@_ver}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmypaint/1.6.1_armv7l/libmypaint-1.6.1-chromeos-armv7l.tpxz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmypaint/1.6.1_armv7l/libmypaint-1.6.1-chromeos-armv7l.tpxz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmypaint/1.6.1_i686/libmypaint-1.6.1-chromeos-i686.tpxz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmypaint/1.6.1_x86_64/libmypaint-1.6.1-chromeos-x86_64.tpxz'
  })
  binary_sha256({
    aarch64: '37363c4d7e13e651dbf6dfa89369711660d6ae9ec844990a05a21a2bdf273429',
     armv7l: '37363c4d7e13e651dbf6dfa89369711660d6ae9ec844990a05a21a2bdf273429',
       i686: 'af0014ecae5d1b074ac61aef18b6b07c63e9ca3d3f6e58c7d4cd2d2bd5440a94',
     x86_64: '797fe6813b0aa1148eebc92949638963b83c51f6ab445da09b7d0acd62f123c3'
  })

  depends_on 'gegl'
  depends_on 'jsonc'

  def self.build
    system 'env NOCONFIGURE=1 ./autogen.sh'
    system "env #{CREW_ENV_OPTIONS} \
      GEGL_LIBS=\"#{CREW_LIB_PREFIX}/gegl-0.4\" \
      GEGL_CFLAGS=\"-I#{CREW_PREFIX}/include/gegl-0.4 \
      -I#{CREW_PREFIX}/include/babl-0.1 \
      -I#{CREW_PREFIX}/include/glib-2.0\" \
      ./configure \
      #{CREW_OPTIONS} \
      --disable-maintainer-mode \
      --enable-openmp \
      --enable-gegl"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
