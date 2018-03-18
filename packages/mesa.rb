require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  version '17.3.6-0'
  source_url 'https://mesa.freedesktop.org/archive/mesa-17.3.6.tar.xz'
  source_sha256 'e5915680d44ac9d05defdec529db7459ac9edd441c9845266eff2e2d3e57fbf8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-17.3.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-17.3.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-17.3.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-17.3.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '31a1e05451b1d8779036c41330f9555c6cb94ecd340285b30fdaee65f856f61d',
     armv7l: '31a1e05451b1d8779036c41330f9555c6cb94ecd340285b30fdaee65f856f61d',
       i686: 'f0abd6726a40a7da699d0d28e40eb7db359ae98ffe41b9dfc302987e5d7841af',
     x86_64: 'd4a38cee8aa4880b376bace883c3451e11730b52b20847f9f724124afbdb862e',
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
        system "./autogen.sh \
                --prefix=#{CREW_PREFIX} \
                --libdir=#{CREW_LIB_PREFIX} \
                --enable-shared-glapi \
                --with-gallium-drivers=i915,r300,r600,radeon,radeonsi,nouveau,svga,swrast,virgl \
                --with-dri-drivers=i915,i965,nouveau,swrast,r200,radeon \
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
