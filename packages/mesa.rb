require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  version '18.3.1-1'
  source_url 'https://mesa.freedesktop.org/archive/mesa-18.3.1.tar.xz'
  source_sha256 '5b1f827d28684a25f6657289f8b7d47ac56395988c7ac23e0ec9a62b644bdc63'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-18.3.1-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-18.3.1-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-18.3.1-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-18.3.1-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd51c117379b69128d7c0e6f9a0554c8d4f9666cf3fb13b5ecdd0897214873192',
     armv7l: 'd51c117379b69128d7c0e6f9a0554c8d4f9666cf3fb13b5ecdd0897214873192',
       i686: '2568b9ad11f52b1554c5720f4b513c26a5ded8d141e97ee01b1eede13e2052bb',
     x86_64: '7d633a3f7e772fc527ec70ab01d8a53126e1ccee204c5c1fb58efdc8ff438b39',
  })

  depends_on 'libva'
  depends_on 'libvdpau'
  depends_on 'wayland'
  depends_on 'elfutils'
  depends_on 'llvm'

  def self.patch
    system "wget -O- https://patchwork.freedesktop.org/patch/257229/raw | patch -Rp1"
  end

  def self.build
    system "pip3 uninstall -y Mako MarkupSafe || :"
    system "pip3 install --prefix \"#{CREW_PREFIX}\" --root \"#{CREW_DEST_DIR}\" Mako==1.0.7"
    system "pip3 install --prefix \"#{CREW_PREFIX}\" Mako==1.0.7"
    case ARCH
    when 'i686'
      gallium_drivers = 'i915,nouveau,pl111,svga,swrast,vc4,virgl'
      dri_drivers = 'i915,i965,nouveau,radeon,r200,swrast'
    when 'x86_64'
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
