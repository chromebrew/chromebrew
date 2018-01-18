require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  version '17.3.2'
  source_url 'ftp://ftp.freedesktop.org/pub/mesa/mesa-17.3.2.tar.xz'
  source_sha256 'e2844a13f2d6f8f24bee65804a51c42d8dc6ae9c36cff7ee61d0940e796d64c6'

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
