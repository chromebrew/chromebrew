require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  version '18.1.0-rc2'
  source_url 'https://mesa.freedesktop.org/archive/mesa-18.1.0-rc2.tar.xz'
  source_sha256 '39f0a0c748edcd13b1bbefbf203be937a7931f3e325a908c59fecc91d1bd008e'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew2/chromebrew2/mesa-18.1.0-rc2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew2/chromebrew2/mesa-18.1.0-rc2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew2/chromebrew2/mesa-18.1.0-rc2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew2/chromebrew2/mesa-18.1.0-rc2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2e9527172429e533abf94840ef8f64f53199f5fd3087685462832a21ff1ff0ae',
     armv7l: '2e9527172429e533abf94840ef8f64f53199f5fd3087685462832a21ff1ff0ae',
       i686: 'c751352db63e6a9dd7f594d758cdc71be4db42c2731d470edae89df597ba363b',
     x86_64: '108bae6bd00ae84906bfd7de1c3d67bc4a2442e409fe21b3e274e9756d4218ab',
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
  depends_on 'llvm'
  depends_on 'elfutils'
  
  def self.build
    #system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} Mako"
    system "pip install --install-option=\"--prefix=#{CREW_PREFIX}\" Mako"
    case ARCH
      when 'x86_64', 'i686'
        system "./autogen.sh"
        system "./configure \
                --prefix=#{CREW_PREFIX} \
                --libdir=#{CREW_LIB_PREFIX} \
                --sysconfdir=#{CREW_PREFIX}/etc \
                --enable-shared-glapi \
                --with-gallium-drivers=i915,r300,r600,radeonsi,nouveau,svga,swrast,virgl \
                --with-dri-drivers=i915,i965,nouveau,swrast,r200 \
                --enable-osmesa \
                --enable-opengl \
                --enable-egl \
                --enable-gles1 \
                --enable-gles2 \
                --with-platforms=x11,drm,wayland \
                --enable-gbm \
                --enable-xa \
                --enable-glx \
                --enable-glx-tls \
                --enable-dri \
                --enable-llvm"
      when 'aarch64', 'armv7l'
        system "./configure \
                --prefix=#{CREW_PREFIX} \
                --libdir=#{CREW_LIB_PREFIX} \
                --sysconfdir=#{CREW_PREFIX}/etc \
                --enable-shared-glapi \
                --with-gallium-drivers=nouveau,freedreno,tegra,vc4,virgl \
                --with-dri-drivers=nouveau,swrast \
                --enable-osmesa \
                --enable-opengl \
                --enable-egl \
                --enable-gles1 \
                --enable-gles2 \
                --with-platforms=x11,drm,wayland \
                --enable-gbm \
                --enable-xa \
                --enable-glx \
                --enable-glx-tls \
                --enable-dri \
                --enable-llvm"
      end
    system "make"
  end
  
  def self.check
    system "make -k -j#{CREW_NPROC} check"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install-strip"
  end
end
