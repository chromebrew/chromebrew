require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  version '17.3.6'
  source_url 'https://mesa.freedesktop.org/archive/mesa-17.3.6.tar.xz'
  source_sha256 'e5915680d44ac9d05defdec529db7459ac9edd441c9845266eff2e2d3e57fbf8'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-17.3.6-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-17.3.6-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-17.3.6-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-17.3.6-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3ea41fb9c2cb997a546e46d5f12211d8770a058c446ba423d66cd2c6b58be98d',
     armv7l: '3ea41fb9c2cb997a546e46d5f12211d8770a058c446ba423d66cd2c6b58be98d',
       i686: 'acd169040bb947b5e0cfbb03f9cb3a3a37b092f7fe5176513d196c4e633c6d09',
     x86_64: 'b9b3aee03c279453044bb07bad1693501b81d29d66fe75f2cdf8e1a79b0754f9',
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

  # tested on armv7l
  def self.build
    system "pip install setuptools"
    system "pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} Mako"
    system "./configure \
            --prefix=#{CREW_PREFIX} \
            --libdir=#{CREW_LIB_PREFIX} \
            --enable-shared-glapi \
            --with-gallium-drivers=nouveau \
            --with-dri-drivers=nouveau \
            --enable-egl \
            --enable-gles1 \
            --enable-gles2 \
            --with-platforms=x11,drm,wayland \
            --enable-gbm \
            --enable-xa \
            --enable-dri"
    system "make"
    system "pip uninstall --yes setuptools"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
