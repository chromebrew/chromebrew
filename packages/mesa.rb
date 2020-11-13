require 'package'

class Mesa < Package
  description 'Open-source implementation of the OpenGL specification'
  homepage 'https://www.mesa3d.org'
  version '20.2.1-3'
  compatibility 'all'
  source_url 'https://mesa.freedesktop.org/archive/mesa-20.2.1.tar.xz'
  source_sha256 'd1a46d9a3f291bc0e0374600bdcb59844fa3eafaa50398e472a36fc65fd0244a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-20.2.1-3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-20.2.1-3-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-20.2.1-3-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mesa-20.2.1-3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0f7bcaa417dc03c46a1d3e7a6abcb6a0d473448b18addc7a0478e0f16a7d37e7',
     armv7l: '0f7bcaa417dc03c46a1d3e7a6abcb6a0d473448b18addc7a0478e0f16a7d37e7',
       i686: '3a0ad01ba8d89930d45a935939c97edf4dd195827179aabfe1126abd9df6de77',
     x86_64: 'a34d88508b68fedd172c30e13a021b9b5c95308a9864507173818452ea75ee5e',
  })

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
