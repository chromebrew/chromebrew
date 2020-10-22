require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  version '20.2.1'
  compatibility 'all'
  source_url 'https://mesa.freedesktop.org/archive/mesa-20.2.1.tar.xz'
  source_sha256 'd1a46d9a3f291bc0e0374600bdcb59844fa3eafaa50398e472a36fc65fd0244a'
  

  depends_on 'setuptools' => :build
  depends_on 'libva'
  depends_on 'libvdpau'
  depends_on 'wayland_protocols'
  depends_on 'elfutils'
  depends_on 'llvm' => :build
  depends_on 'meson' => :build
  depends_on 'libdrm'
  depends_on 'libunwind' => :build
  depends_on 'vulkan_headers' => :build
  depends_on 'vulkan_icd_loader' => :build
  depends_on 'glslang' => :build
  depends_on 'zstd' => :build

  def self.build
    system "pip3 uninstall -y Mako MarkupSafe || :"
    system "pip3 install --prefix \"#{CREW_PREFIX}\" --root \"#{CREW_DEST_DIR}\" Mako"
    system "pip3 install --prefix \"#{CREW_PREFIX}\" Mako"
    # Workaround for lld having issues with gcc(8?) on arm7l.
    if ARCH =~ /^(x86_64|i686|aarch64)$/
      ENV['CFLAGS'] = "-fuse-ld=lld"
      ENV['CXXFLAGS'] = "-fuse-ld=lld"
    end
    # Just use mostly defaults.
    system "meson",
      "-Dprefix=#{CREW_PREFIX}",
      "-Dlibdir=#{CREW_LIB_PREFIX}",
      "-Dbuildtype=release",
      "builddir"
    system "ninja -C builddir"
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"

  end
end
