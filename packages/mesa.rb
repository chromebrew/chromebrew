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
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"

  end
end
