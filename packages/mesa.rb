require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  version '17.3.2'
  source_url 'https://mesa.freedesktop.org/archive/mesa-17.3.2.tar.xz'
  source_sha256 'e2844a13f2d6f8f24bee65804a51c42d8dc6ae9c36cff7ee61d0940e796d64c6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-17.3.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-17.3.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-17.3.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-17.3.2-chromeos-x86_64.tar.xz',

  })
  binary_sha256 ({
    aarch64: 'a471dcc099c172ad9113f93adfa5878aac25235a9db60c1d4c68d8c1a7df112f',
     armv7l: 'a471dcc099c172ad9113f93adfa5878aac25235a9db60c1d4c68d8c1a7df112f',
       i686: '7a01dc3d49956d87b246a56d9c4ed0f14fc12945d56f1735bccb9f2477c7426e',
     x86_64: 'f069566c26b2b125c7d86afcd410cc90ca75ea1a62ad747271a6aa2f1f48dbec',

  })

  depends_on 'libdrm'
  depends_on 'xorg_proto'
  depends_on 'libx11'
  depends_on 'libxext'
  depends_on 'libxfixes'
  depends_on 'libxdamage'
  depends_on 'libxcb'
  depends_on 'libxtrans'
  depends_on 'libxkbfile'
  depends_on 'wayland'
  depends_on 'python27'
  depends_on 'bison'
  depends_on 'libxshmfence'
  # tested on armv7l
  def self.build
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} Mako"
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --enable-shared-glapi \
            --with-gallium-drivers=nouveau \
            --with-dri-drivers=nouveau \
            --enable-egl \
            --with-platforms=x11,drm,wayland \
            --enable-gbm \
            --enable-xa \
            --enable-dri"    
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
