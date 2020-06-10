require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  version '20.0.2'
  compatibility 'all'
  source_url 'https://mesa.freedesktop.org/archive/mesa-20.0.2.tar.xz'
  source_sha256 'aa54f1cb669550606aab8ceb475105d15aeb814fca5a778ce70d0fd10e98e86f'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-20.0.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-20.0.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-20.0.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-20.0.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '1032dfef942c6fba1862daf15e2f9a3f6221d68b125e11cba953f27393059004',
     armv7l: '1032dfef942c6fba1862daf15e2f9a3f6221d68b125e11cba953f27393059004',
       i686: 'd59403d96e51bd16af361792732e6065b58b56b71ae621884f47d30f3e2a4a1c',
     x86_64: 'f7017c11eb0671f0ca9d0368e7c03d7668673c824af96f6238f183e72b033202',
  })

  depends_on 'setuptools' => :build
  depends_on 'libva'
  depends_on 'libvdpau'
  depends_on 'wayland_protocols'
  depends_on 'elfutils'
  depends_on 'llvm'

  def self.build
    system "pip3 uninstall -y Mako MarkupSafe || :"
    system "pip3 install --prefix \"#{CREW_PREFIX}\" --root \"#{CREW_DEST_DIR}\" Mako"
    system "pip3 install --prefix \"#{CREW_PREFIX}\" Mako"
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
