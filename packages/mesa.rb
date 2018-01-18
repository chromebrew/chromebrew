require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  version '17.1.5'
  source_url 'ftp://ftp.freedesktop.org/pub/mesa/mesa-17.1.5.tar.xz'
  source_sha256 '378516b171712687aace4c7ea8b37c85895231d7a6d61e1e27362cf6034fded9'

  binary_url ({
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-17.1.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-17.1.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
       i686: '54e67d2890dc0a134e105007082d1a14e64b0ef58aed5c37c47815b51e0a9b9c',
     x86_64: '9c4af5498c04673929ef3b88ea53bd0dce8bad5010b2a74803eb82539b253ca9',
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
