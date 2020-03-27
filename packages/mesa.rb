require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  version '20.0.2'
  source_url 'https://mesa.freedesktop.org/archive/mesa-20.0.2.tar.xz'
  source_sha256 'aa54f1cb669550606aab8ceb475105d15aeb814fca5a778ce70d0fd10e98e86f'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'libva'
  depends_on 'libvdpau'
  depends_on 'wayland_protocols'
  depends_on 'elfutils'
  depends_on 'llvm'

  def self.patch
   # system "wget -O- https://patchwork.freedesktop.org/patch/257229/raw | patch -Rp1"
  end

  def self.build
    system "pip3 uninstall -y Mako MarkupSafe || :"
    system "pip3 install --prefix \"#{CREW_PREFIX}\" --root \"#{CREW_DEST_DIR}\" Mako==1.0.7"
    system "pip3 install --prefix \"#{CREW_PREFIX}\" Mako==1.0.7"
#    case ARCH
#    when 'i686'
#      gallium_drivers = 'i915,nouveau,pl111,svga,swrast,vc4,virgl'
#      dri_drivers = 'i915,i965,nouveau,radeon,r200,swrast'
#    when 'x86_64'
#      gallium_drivers = 'i915,nouveau,r300,r600,radeonsi,pl111,svga,swrast,swr,vc4,virgl'
#      dri_drivers = 'i915,i965,nouveau,radeon,r200,swrast'
#    when 'aarch64', 'armv7l'
#      gallium_drivers = 'nouveau,r300,freedreno,pl111,swrast,tegra,vc4,virgl'
#      dri_drivers = 'nouveau,radeon,r200,swrast'
#    end
    system "meson",
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      "-Dshared-glapi=true",
      "-Dgallium-drivers=auto",
      "-Ddri-drivers=auto",
      "-Dosmesa=classic",
      "-Dopengl=true",
      "-Degl=auto",
      "-Dgallium-xvmc=auto",
      "-Dgallium-nine=true",
      "-Dgles1=auto",
      "-Dgles2=auto",
      "-Dplatforms=x11,drm,wayland",
      "-Dgbm=auto",
      "-Dgallium-xa=auto",
      "-Dglx=auto",
      "-Dllvm=true",
      "builddir"
#    system "./configure",
#           "--prefix=#{CREW_PREFIX}",
#           "--libdir=#{CREW_LIB_PREFIX}",
#           "--enable-shared-glapi",
#           "--with-gallium-drivers=#{gallium_drivers}",
#           "--with-dri-drivers=#{dri_drivers}",
#           "--enable-osmesa",
#           "--enable-opengl",
#           "--enable-egl",
#           "--enable-xvmc",
#           "--disable-asm",
#           "--enable-nine",
#           "--enable-gles1",
#           "--enable-gles2",
#           "--with-platforms=x11,drm,wayland",
#           "--enable-gbm",
#           "--enable-xa",
#           "--enable-glx",
#           "--enable-dri",
#           "--enable-llvm"
#    system "make"
    system "ninja -C builddir"
  end

  def self.install
#    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"

  end
end
