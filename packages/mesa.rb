require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  version '18.3.1'
  source_url 'https://mesa.freedesktop.org/archive/mesa-18.3.1.tar.xz'
  source_sha256 '5b1f827d28684a25f6657289f8b7d47ac56395988c7ac23e0ec9a62b644bdc63'

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
  depends_on 'libxvmc'
  depends_on 'libxtrans'
  depends_on 'libxkbfile'
  depends_on 'wayland'
  depends_on 'python27'
  depends_on 'bison'
  depends_on 'libxshmfence'
  depends_on 'elfutils'
  depends_on 'llvm'
  
  def self.build
    system "pip uninstall -y Mako MarkupSafe || :"
    system "pip install --prefix \"#{CREW_PREFIX}\" --root \"#{CREW_DEST_DIR}\" Mako==1.0.7"
    system "pip install --prefix \"#{CREW_PREFIX}\" Mako==1.0.7"
    case ARCH
      when 'i686', 'x86_64'
      gallium_drivers = 'i915,nouveau,r300,r600,radeonsi,pl111,svga,swrast,swr,vc4,virgl'
      dri_drivers = 'i915,i965,nouveau,radeon,r200,swrast'
    when 'aarch64', 'armv7l'
      gallium_drivers = 'nouveau,r300,freedreno,pl111,swrast,tegra,vc4,virgl'
      dri_drivers = 'nouveau,radeon,r200,swrast'
    end
    system "./configure",
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--enable-shared-glapi",
           "--with-gallium-drivers=#{gallium_drivers}",
           "--with-dri-drivers=#{dri_drivers}",
           "--enable-osmesa",
           "--enable-opengl",
           "--enable-egl",
           "--enable-xvmc",
           "--disable-asm",
           "--enable-nine",
           "--enable-gles1",
           "--enable-gles2",
           "--with-platforms=x11,drm,wayland",
           "--enable-gbm",
           "--enable-xa",
           "--enable-glx",
           "--enable-dri",
           "--enable-llvm"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
