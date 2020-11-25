require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  version '20.2.3'
  compatibility 'all'
  source_url 'https://mesa.freedesktop.org/archive/mesa-20.2.3.tar.xz'
  source_sha256 'ae1b240e11531df528d14dc214d2dc4d2b4f2e835c6230ba0b492b171eceb82b'

  depends_on 'llvm' => :build
  depends_on 'elfutils'
  depends_on 'glslang'
  depends_on 'libdrm'
  depends_on 'libomxil_bellagio'
  depends_on 'libunwind'
  depends_on 'libvdpau'
  depends_on 'libxdamage'
  depends_on 'libxshmfence'
  depends_on 'libxv'
  depends_on 'libxvmc'
  depends_on 'libxxf86vm'
  depends_on 'valgrind'
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader'
  depends_on 'wayland_protocols'
  depends_on 'zstd'

  def self.build
    system "pip3 uninstall -y Mako MarkupSafe || :"
    system "pip3 install --prefix \"#{CREW_PREFIX}\" --root \"#{CREW_DEST_DIR}\" Mako"
    system "pip3 install --prefix \"#{CREW_PREFIX}\" Mako"
    
    ENV['CFLAGS'] = "-fuse-ld=lld"
    ENV['CXXFLAGS'] = "-fuse-ld=lld"

    # Just use mostly defaults.
    system "meson #{CREW_MESON_OPTIONS} builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
