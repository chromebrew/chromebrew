require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  version '18.1.5'
  source_url 'https://mesa.freedesktop.org/archive/mesa-18.1.5.tar.xz'
  source_sha256 '69dbe6f1a6660386f5beb85d4fcf003ee23023ed7b9a603de84e9a37e8d98dea'

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
        system "./autogen.sh \
                --prefix=#{CREW_PREFIX} \
                --libdir=#{CREW_LIB_PREFIX} \
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
                --enable-glx\
                --enable-dri \
                --enable-llvm"
      when 'aarch64', 'armv7l'
        system "./configure \
                --prefix=#{CREW_PREFIX} \
                --libdir=#{CREW_LIB_PREFIX} \
                --enable-shared-glapi \
                --with-gallium-drivers=nouveau,freedreno,vc4,virgl \
                --with-dri-drivers=nouveau,swrast \
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
