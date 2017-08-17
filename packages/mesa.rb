require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  version '17.1.5'
  source_url 'ftp://ftp.freedesktop.org/pub/mesa/mesa-17.1.5.tar.xz'
  source_sha256 '378516b171712687aace4c7ea8b37c85895231d7a6d61e1e27362cf6034fded9'

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

  def self.build
    system "./configure --enable-gles2 --with-egl-platforms=x11,wayland,drm --enable-gbm --enable-shared-glapi --with-gallium-drivers=swrast --disable-dri3"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
