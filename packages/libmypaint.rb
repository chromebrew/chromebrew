require 'package'

class Libmypaint < Package
  description 'Libmypaint is MyPaint\'s brushstroke rendering code, in a form that can be used by other programs.'
  homepage 'http://mypaint.org/'
  version '1.6.1'
  license 'ISC'
  compatibility 'all'
  source_url 'https://github.com/mypaint/libmypaint/releases/download/v1.6.1/libmypaint-1.6.1.tar.xz'
  source_sha256 '741754f293f6b7668f941506da07cd7725629a793108bb31633fb6c3eae5315f'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmypaint/1.6.1_armv7l/libmypaint-1.6.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmypaint/1.6.1_armv7l/libmypaint-1.6.1-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmypaint/1.6.1_i686/libmypaint-1.6.1-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libmypaint/1.6.1_x86_64/libmypaint-1.6.1-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'd4771b0d30a84a37170863f83158f18c3ba5d2cbe49d8ba40f07bf4b9dd9193b',
     armv7l: 'd4771b0d30a84a37170863f83158f18c3ba5d2cbe49d8ba40f07bf4b9dd9193b',
       i686: '2073f128ff52c6e7ea2f0a1499eaffc779ff7fee82a15cdbcf20cfd8c79a3fad',
     x86_64: 'c9e0ec9d662a735f5e4373c5222ac37931bbd21e15314e80af0b14f1cdabe8c2'
  })

  depends_on 'gegl'
  depends_on 'jsonc'

  def self.build
    system "env CFLAGS='-pipe -flto=auto' \
      CXXFLAGS='-pipe -flto=auto' \
      LDFLAGS='-flto=auto' \
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
