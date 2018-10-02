require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  version '18.1.5'
  source_url 'https://mesa.freedesktop.org/archive/mesa-18.1.5.tar.xz'
  source_sha256 '69dbe6f1a6660386f5beb85d4fcf003ee23023ed7b9a603de84e9a37e8d98dea'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-18.1.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-18.1.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-18.1.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-18.1.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd400200b0cc619601b7691e9b83ff7986c561d4f7d43d84d3d0f3eab38eae6a5',
     armv7l: 'd400200b0cc619601b7691e9b83ff7986c561d4f7d43d84d3d0f3eab38eae6a5',
       i686: '375714b84a1e3d3f3b95bd363192c9d6dc793484f973b5d11c7be0748c915812',
     x86_64: 'b29ed0fb8b26de64e995de0a3bbc2390d8c0b0ab130cc75711e3ed367296e1a0',
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
  depends_on 'elfutils'
  
  def self.build
    #system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} Mako"
    system "pip install --install-option=\"--prefix=#{CREW_PREFIX}\" Mako"
    case ARCH
      when 'x86_64', 'i686'
        system "./autogen.sh \
                --prefix=#{CREW_PREFIX} \
                --libdir=#{CREW_LIB_PREFIX} \
                --enable-shared-glapi \
                --with-gallium-drivers=i915,nouveau,r300,r600,radeonsi,pl111,svga,swrast,swr,tegra,vc4,virgl \
                --with-dri-drivers=i915,i965,nouveau,radeon,r200,swrast \
                --enable-osmesa \
                --enable-opengl \
                --enable-egl \
                --enable-gles1 \
                --enable-gles2 \
                --with-platforms=x11,drm,wayland \
                --enable-gbm \
                --enable-xa \
                --enable-glx\
                --enable-dri \
                --enable-llvm"
      when 'aarch64', 'armv7l'
        system "./configure \
                --prefix=#{CREW_PREFIX} \
                --libdir=#{CREW_LIB_PREFIX} \
                --enable-shared-glapi \
                --with-gallium-drivers=nouveau,r300,freedreno,pl111,swrast,tegra,vc4,virgl \
                --with-dri-drivers=nouveau,radeon,r200,swrast \
                --enable-osmesa \
                --enable-opengl \
                --enable-egl \
                --enable-gles1 \
                --enable-gles2 \
                --with-platforms=x11,drm,wayland \
                --enable-gbm \
                --enable-xa \
                --enable-glx\
                --enable-dri \
                --enable-llvm"
      end
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
