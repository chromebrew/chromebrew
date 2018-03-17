require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  version '17.3.6'
  source_url 'https://mesa.freedesktop.org/archive/mesa-17.3.6.tar.xz'
  source_sha256 'e5915680d44ac9d05defdec529db7459ac9edd441c9845266eff2e2d3e57fbf8'

  binary_url ({

  })
  binary_sha256 ({

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
            --enable-gles1 \
            --enable-gles2 \
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
