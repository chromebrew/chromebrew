require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  version '20.2.0'
  compatibility 'all'
  source_url 'https://mesa.freedesktop.org/archive/mesa-20.2.0.tar.xz'
  source_sha256 '63f0359575d558ef98dd78adffc0df4c66b76964ebf603b778b7004964191d30'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-20.2.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-20.2.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-20.2.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-20.2.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '48ea7803900737f3cb039916a194803df7c74350856baf1e32867f4c7dbaffc4',
     armv7l: '48ea7803900737f3cb039916a194803df7c74350856baf1e32867f4c7dbaffc4',
       i686: '09e41a089c50399f2b5667d19214df84e7542c1e35a9f2a48e3b1d1c844df69e',
     x86_64: '8dc082dc17b1ba23d3e6590b7696dbdfcb63ed5a03fb22c7682ecd6fce529642',
  })

  depends_on 'setuptools' => :build
  depends_on 'libva'
  depends_on 'libvdpau'
  depends_on 'wayland_protocols'
  depends_on 'elfutils'
  depends_on 'llvm'
  depends_on 'libdrm'

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
