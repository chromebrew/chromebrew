require 'package'

class Libmypaint < Package
  description 'Libmypaint is MyPaint\'s brushstroke rendering code, in a form that can be used by other programs.'
  homepage 'http://mypaint.org/'
  @_ver = '1.6.1'
  version @_ver
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/mypaint/libmypaint.git'
  git_hashtag 'v' + @_ver

  depends_on 'gegl'
  depends_on 'jsonc'

  def self.build
    system "env NOCONFIGURE=1 ./autogen.sh"
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
